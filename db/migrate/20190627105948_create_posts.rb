class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :score
      t.string :comments_url
      t.string :article_url
      t.integer :comment_count
      t.string :title
      t.string :domain
      t.string :summary
      t.string :type

      t.timestamps
    end
  end
end
