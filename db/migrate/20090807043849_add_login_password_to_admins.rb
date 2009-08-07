class AddLoginPasswordToAdmins < ActiveRecord::Migration
  def self.up
    add_column :admins, :login, :string
    add_column :admins, :crypted_password, :string
    add_column :admins, :password_salt, :string
    add_column :admins, :persistence_token, :string
  end

  def self.down
    remove_column :admins, :crypted_password
    remove_column :admins, :password_salt
    remove_column :admins, :persistence_token
    remove_column :admins, :login
  end
end
