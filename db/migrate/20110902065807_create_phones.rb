class CreatePhones < ActiveRecord::Migration
  def self.up
    create_table :phones do |t|
	  t.integer :phone_number
	  t.string :phonetype
      t.timestamps
    end
    create_default
  end

  def self.down
    drop_table :phones
  end
  
  def self.create_default
  	clist = ["Home",
  			 "Office",
  			 "Mobile"]
  	clist.each do |c|
      @c1 = Phone.new
      @c1.phonetype = c
      @c1.save
  end
  end
end
