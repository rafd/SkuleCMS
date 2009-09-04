class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.integer :club_id
      t.string :type
      t.string :name
      t.string :value
      
      t.timestamps
    end
  end

  def self.down
    drop_table :settings
  end
end
