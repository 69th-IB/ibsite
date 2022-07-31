module Arma
end

class Arma::Server
  include Singleton

  attr_reader :config, :cfgfile, :container

  def initialize
    # Docker::Image.create fromImage: "frozendroid/arma3server"
  end

  def started? = !@container.nil?

  def start(validate_install = true)
    webhost = ENV["WEBHOST"]
    volume_path = ENV["VOLUME_PATH"]

    if webhost.nil? or volume_path.nil?
      raise "WEBHOST and VOLUME_PATH must be set"
    end

    @config = ServerConfig.last

    mission_name = @config.mission.pbo_file.filename

    mission_path = "#{volume_path}/mpmissions/#{mission_name}"

    mission_file = File.open(mission_path, "wb")
    mission_file.write(@config.mission.pbo_file.download)

    @cfgfile = Tempfile.new("arma3.cfg")
    @cfgfile.write <<EOF
      #{@config.body}

      class Missions {
        class TodaysMission {
          template = #{mission_name.base};
          difficulty = "Custom";
        };
      };
EOF

    @cfgfile.close

    @container = Docker::Container.create(
      name: Rails.configuration.arma.container_name,
      Image: "frozendroid/arma3server",
      ExposedPorts: {
        "2302/udp" => {},
        "2303/udp" => {},
        "2304/udp" => {},
        "2305/udp" => {},
        "2306/udp" => {},
      },
      Volumes: {
        "/arma3" => {},
        "/arma3/configs/69th.cfg" => {},
      },
      Env: [
        "ARMA_PARAMS=" + @config.params,
        "ARMA_LIMITFPS=" + @config.maxfps.to_s,
        "ARMA_CDLC=" + @config.creator_dlc,
        "ARMA_CONFIG=69th.cfg",
        "ARMA_PROFILE=69th",
        "ARMA_BINARY=./arma3server_x64",
        "MODS_PRESET=" + "#{webhost}/modlists/#{@config.modlist_id}/preset",
        "HEADLESS_CLIENTS=" + @config.headless_clients.to_s,
        "STEAM_USER=" + Rails.application.credentials.steam.username,
        "STEAM_PASSWORD=" + Rails.application.credentials.steam.password,
        "STEAM_BRANCH=" + @config.branch,
        "SKIP_INSTALL=" + (not validate_install).to_s,
      ],
      HostConfig: {
        AutoRemove: true,
        Binds: [
          "#{volume_path}:/arma3",
          "#{cfgfile.path}:/arma3/configs/69th.cfg",
        ],
        PortBindings: {
          "2302/udp" => [ { HostPort: "2302" } ],
          "2303/udp" => [ { HostPort: "2303" } ],
          "2304/udp" => [ { HostPort: "2304" } ],
          "2305/udp" => [ { HostPort: "2305" } ],
          "2306/udp" => [ { HostPort: "2306" } ],
        },
      },
    )

    @container.start

    ActionCable.server.broadcast(:manage_server_channel, {
      state: "started"
    })

    container = @container
    Thread.new do
      last_send = Time.now
      buffer = ""

      container.attach do |stream, chunk|
        buffer += chunk.encode("UTF-8", invalid: :replace, undef: :replace)

        if Time.now - last_send > 1.5
          ActionCable.server.broadcast(:manage_server_channel, {
            log: buffer,
          })

          buffer = ""
          last_send = Time.now
        end
      end
    end
  end

  def stop
    @container.stop
    @cfgfile.unlink
    @container = nil

    ActionCable.server.broadcast(:manage_server_channel, {
      state: "stopped"
    })
  end
end
