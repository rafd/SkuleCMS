class AddRssLinkToClub < ActiveRecord::Migration
  def self.up
    add_column :clubs, :rss_link, :string
  end

  def self.down
    remove_column :clubs, :rss_link
  end
end
