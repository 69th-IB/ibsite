class CreateModlists < ActiveRecord::Migration[7.0]
  def change
    create_table :modlists do |t|
      t.string :title
      t.boolean :published, default: false
      t.integer :creator_id

      t.timestamps
    end
  end
end
