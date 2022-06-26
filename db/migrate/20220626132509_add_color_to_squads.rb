class AddColorToSquads < ActiveRecord::Migration[7.0]
  def change
    add_column :squads, :color, :string
  end
end
