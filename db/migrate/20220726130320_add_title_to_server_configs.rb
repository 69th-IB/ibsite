class AddTitleToServerConfigs < ActiveRecord::Migration[7.0]
  def change
    add_column :server_configs, :title, :string
  end
end
