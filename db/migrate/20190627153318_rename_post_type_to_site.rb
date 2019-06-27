class RenamePostTypeToSite < ActiveRecord::Migration[5.2]
  def change
  	rename_column :posts, :type, :site
  end
end
