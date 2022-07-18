class Discord::RolePermission < ApplicationRecord
  belongs_to :role, class_name: "Discord::Role"

  PERMISSIONS = %w[
    manage_server
    manage_modlists
    create_missions
    modify_others_missions
    delete_missions
    view_draft_missions
    view_missions_early
    enlist_self
    enlist_others
    override_enlistment
  ]

  validates :key, inclusion: { in: PERMISSIONS }
end
