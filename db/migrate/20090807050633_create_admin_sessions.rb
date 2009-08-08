class CreateAdminSessions < ActiveRecord::Migration
  def self.up
    create_table :admin_sessions do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :admin_sessions
  end
end
