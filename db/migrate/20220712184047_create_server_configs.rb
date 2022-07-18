class CreateServerConfigs < ActiveRecord::Migration[7.0]
  def change
    create_table :server_configs do |t|
      t.string :params
      t.string :branch
      t.string :creator_dlc
      t.integer :maxfps
      t.integer :headless_clients
      t.references :modlist, null: false, foreign_key: true
      t.references :mission, null: false, foreign_key: true
      t.string :body

      t.timestamps
    end
  end
end
