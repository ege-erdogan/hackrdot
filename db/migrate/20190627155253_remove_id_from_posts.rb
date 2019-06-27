class RemoveIdFromPosts < ActiveRecord::Migration[5.2]
  def change
  	remove_column :posts, :id
  end
end
