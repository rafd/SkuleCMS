class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :club_id
      t.integer :user_id
      t.datetime :start
      t.datetime :end
      t.string :location
      t.string :description
      t.string :link

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
