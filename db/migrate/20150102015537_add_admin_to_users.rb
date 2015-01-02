class AddAdminToUsers < ActiveRecord::Migration
  def change
  	#Code11.39
    add_column :users, :admin, :boolean, default: false
  end
end
