class UseUuidForUsers < ActiveRecord::Migration[5.2]
  def change
    drop_table :users

  	create_table :users, id: false do |t|
  		t.string :id, primary_key: true
  		t.string :name
  		t.string :email
  		t.string :password_digest
  		t.string :remember_digest

  		t.timestamps
  	end

  	add_index :users, :email, unique: true
  end
end
