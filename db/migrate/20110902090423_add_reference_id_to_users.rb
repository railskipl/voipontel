class AddReferenceIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :reference_id, :integer
  end

  def self.down
    remove_column :users, :reference_id
  end
end
