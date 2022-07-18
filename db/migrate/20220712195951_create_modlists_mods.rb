class CreateModlistsMods < ActiveRecord::Migration[7.0]
  def change
    create_table :modlists_mods do |t|
      t.references :modlist, null: false, foreign_key: true
      t.references :mod, null: false, foreign_key: true
      t.boolean :optional, default: false

      t.timestamps
    end
  end
end
