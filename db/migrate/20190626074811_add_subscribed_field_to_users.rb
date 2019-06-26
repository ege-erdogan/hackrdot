class AddSubscribedFieldToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :subscribed, :boolean
  end
end
