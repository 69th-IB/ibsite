class ServerConfig < ApplicationRecord
  belongs_to :modlist
  belongs_to :mission

  def cdlc
    creator_dlc.downcase.split(";")
  end

  def vn? = cdlc.any?("vn")
  def ws? = cdlc.any?("ws")
  def spe? = cdlc.any?("spe")
  def gm? = cdlc.any?("gm")
end
