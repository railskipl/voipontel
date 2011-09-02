class CreateReferences < ActiveRecord::Migration
  def self.up
    create_table :references do |t|
	  t.boolean :is_refeered
	  t.string :first_name
	  t.string :last_name
	  t.integer :phone_number
      t.timestamps
    end
  end

  def self.down
    drop_table :references
  end
end
