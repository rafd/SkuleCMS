class AddWeblinkToExternalPost < ActiveRecord::Migration
  def self.up
    add_column :external_posts, :weblink, :string
  end

  def self.down
    remove_column :external_posts, :weblink
  end
end
