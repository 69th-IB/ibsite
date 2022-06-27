class AddNickAndColorToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :discord_nick, :string
    add_column :users, :discord_color, :string
  end
end
