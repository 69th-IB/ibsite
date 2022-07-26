class CreateMods < ActiveRecord::Migration[7.0]
  def change
    create_table :mods do |t|
      t.string :title
      t.integer :workshop_id
      t.integer :file_size

      t.timestamps
    end
  end
end
