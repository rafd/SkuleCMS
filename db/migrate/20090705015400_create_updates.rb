class CreateUpdates < ActiveRecord::Migration
  def self.up
    create_table :updates do |t|
      t.integer :club_id
      t.integer :user_id
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :updates
  end
end
