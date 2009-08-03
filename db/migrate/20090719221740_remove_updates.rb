class RemoveUpdates< ActiveRecord::Migration
  def self.up
    drop_table :updates
  end
end