class Arma::Server
  include Singleton

  def initialize
    # Docker::Image.create fromImage: "frozendroid/arma3server"
  end

  def start
    @container = Docker::Container.create(
      name: Rails.configuration.arma.development.container_name,
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
      },
      Env: [
        "ARMA_PARAMS=-autoInit",
        "ARMA_LIMITFPS=60",
        "ARMA_CONFIG=69th.cfg",
        "ARMA_PROFILE=69th",
        "ARMA_BINARY=./arma3server_x64",
        "MODS_PRESET=SOG_PF_Op.html",
        "STEAM_USER=" + Rails.application.credentials.steam.username,
        "STEAM_PASSWORD=" + Rails.application.credentials.steam.password,
      ],
      HostConfig: {
        AutoRemove: true,
        Binds: [
          "/mnt/c/ArmaServer:/arma3",
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
  end
end
