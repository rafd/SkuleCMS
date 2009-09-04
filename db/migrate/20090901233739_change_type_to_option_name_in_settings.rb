class ChangeTypeToOptionNameInSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :option_name, :string
    remove_column :settings, :type
  end

  def self.down
    remove_column :settings, :option_name
    add_column :settings, :type, :string
  end
end
