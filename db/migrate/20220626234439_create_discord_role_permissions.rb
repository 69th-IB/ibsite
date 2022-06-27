class CreateDiscordRolePermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :discord_role_permissions do |t|
      t.references :role, null: false
      t.string :key

      t.timestamps

      t.index [:role_id, :key], unique: true
    end
  end
end
