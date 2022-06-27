class RenamePublishedToDraftInMissions < ActiveRecord::Migration[7.0]
  def change
    rename_column :missions, :published, :draft
    change_column_default :missions, :draft, from: false, to: true
  end
end
