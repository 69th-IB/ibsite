class CreateMissions < ActiveRecord::Migration[7.0]
  def change
    create_table :missions do |t|
      t.string :title, null: false, default: "Operation"
      t.datetime :start
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.boolean :published, null: false, default: false
      t.boolean :public, null: false, default: false

      t.timestamps
    end

    create_table :squads do |t|
      t.string :name
      t.references :mission, null: false, foreign_key: true
      t.references :parent, foreign_key: { to_table: :squads }

      t.timestamps
    end

    create_table :slots do |t|
      t.string :name
      t.references :squad, null: false, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
