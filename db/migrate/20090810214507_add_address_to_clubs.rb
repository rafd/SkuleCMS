class AddAddressToClubs < ActiveRecord::Migration
  def self.up
    add_column :clubs, :address, :string
  end

  def self.down
    remove_column :clubs, :address
  end
end
