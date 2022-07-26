class CreateModlists < ActiveRecord::Migration[7.0]
  def change
    create_table :modlists do |t|
      t.string :title
      t.integer :creator_id
      t.datetime :published_at
      t.integer :parent_id

      t.timestamps
    end
  end
end
