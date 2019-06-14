class CreateBookmarksUsers < ActiveRecord::Migration[5.2]
  def change
 		drop_table :users_bookmarks

    create_table :bookmarks_users, id: false do |t|
    	t.belongs_to :user, index: true
    	t.belongs_to :bookmark, index: true
  	end
  end
end
