class Discord::Role < ApplicationRecord
  has_many :permissions, class_name: "Discord::RolePermission"

  has_and_belongs_to_many :users,
    join_table: :discord_role_members

  def can?(permission)
    admin? || permissions.where(key: permission.to_s).exists?
  end

  def css_color(default = "inherit")
    return default if color.nil?
    "##{color}"
  end
end
