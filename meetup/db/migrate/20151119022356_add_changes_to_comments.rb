class AddChangesToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :user_id, :integer
  	remove_columns :comments, :username, :email
  end
end
