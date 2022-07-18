class ServerConfig < ApplicationRecord
  belongs_to :modlist
  belongs_to :mission

  has_one_attached :pbo_file
end
