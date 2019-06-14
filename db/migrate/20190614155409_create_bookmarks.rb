class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.string :title
      t.string :comments_url
      t.string :type

      t.timestamps
    end
  end
end
