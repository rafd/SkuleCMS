class CreateAdmins < ActiveRecord::Migration
  def self.up
    create_table :admins do |t|
      t.integer :user_id
      t.integer :club_id
      t.boolean :event
      t.boolean :update
      t.boolean :member
      t.boolean :group
      t.boolean :file
      t.boolean :gallery

      t.timestamps
    end
  end

  def self.down
    drop_table :admins
  end
end
