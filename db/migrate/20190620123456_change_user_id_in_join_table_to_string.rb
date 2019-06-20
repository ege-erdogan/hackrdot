class ChangeUserIdInJoinTableToString < ActiveRecord::Migration[5.2]
  def change
  	change_column :bookmarks_users, :user_id, :string
  end
end
