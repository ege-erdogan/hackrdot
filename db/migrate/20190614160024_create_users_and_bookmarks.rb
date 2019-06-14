class CreateUsersAndBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :users_bookmarks, id: false do |t|
    	t.belongs_to :user, index: true
    	t.belongs_to :bookmark, index: true
    end
  end
end
