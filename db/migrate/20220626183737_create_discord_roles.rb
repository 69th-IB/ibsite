class CreateDiscordRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :discord_roles do |t|
      t.string :uid, null: false
      t.string :name, null: false
      t.string :color, null: true
      t.integer :position, null: false
      t.boolean :admin, null: false, default: false

      t.timestamps

      t.index :uid, unique: true
    end

    create_table :discord_role_members do |t|
      t.string :user_id, null: false
      t.string :role_id, null: false

      t.timestamps

      t.index [:user_id, :role_id], unique: true
    end
  end
end
