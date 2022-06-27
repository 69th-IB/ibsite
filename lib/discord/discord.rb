class Discord::Discord
  include Singleton

  attr_reader :bot

  def initialize
    @bot = Discordrb::Bot.new(
      token: Rails.application.credentials.discord.bot_token,
    )

    @bot.run :async
  end

  def server_id = Rails.application.credentials.discord.ib_server_id
  def server = @bot.server(server_id)
  def server_roles = server.roles
  def member_roles(uid) = server.member(uid)&.roles
end

# <Role
# name=big gay permissions=#<Discordrb::Permissions:0x000055bebbf7fd08 @writer=<RoleWriter role=#<Discordrb::Role:0x000055bebbf7fd58> token=...>, @bits=104320577, @create_instant_invite=true, @kick_members=false, @ban_members=false, @administrator=false, @manage_channels=false, @manage_server=false, @add_reactions=true, @view_audit_log=false, @priority_speaker=false, @stream=true, @read_messages=true, @send_messages=true, @send_tts_messages=false, @manage_messages=false, @embed_links=true, @attach_files=true, @read_message_history=true, @mention_everyone=true, @use_external_emoji=true, @view_server_insights=false, @connect=true, @speak=true, @mute_members=false, @deafen_members=false, @move_members=false, @use_voice_activity=true, @change_nickname=true, @manage_nicknames=false, @manage_roles=false, @manage_webhooks=false, @manage_emojis=false>
# hoist=false
# colour=#<Discordrb::ColourRGB:0x000055bebbf7f330 @combined=15277667, @red=233, @green=30, @blue=99>
# server=<Server name=darkness id=965692735430459462 large= region= owner= afk_channel_id= system_channel_id=965692735430459465 afk_timeout=300>
# position=1
# mentionable=false>
