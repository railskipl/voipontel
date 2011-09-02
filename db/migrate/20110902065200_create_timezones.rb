class CreateTimezones < ActiveRecord::Migration
  def self.up
    create_table :timezones do |t|
		t.string :timezone
        t.timestamps
    end
    create_default
  end
  
  
  def self.down
    drop_table :timezones
  end
  
  def self.create_default
  	clist = ["(GMT -12:00) Eniwetok, Kwajalein",
  			 "(GMT -11:00) Midway Island, Samoa",
  			 "(GMT -10:00) Hawaii",
  			 "(GMT -9:00) Alaska",
  			 "(GMT -8:00) Pacific Time (US &amp; Canada)",
  			 "(GMT -7:00) Mountain Time (US &amp; Canada)",
  			 "(GMT -6:00) Central Time (US &amp; Canada), Mexico City",
  			 "(GMT -5:00) Eastern Time (US &amp; Canada), Bogota, Lima",
  			 "(GMT -4:00) Atlantic Time (Canada), Caracas, La Paz",
  			 "(GMT -3:30) Newfoundland",
  			 "(GMT -3:00) Brazil, Buenos Aires, Georgetown",
  			 "(GMT -2:00) Mid-Atlantic",
  			 "(GMT -1:00 hour) Azores, Cape Verde Islands",
  			 "(GMT) Western Europe Time, London, Lisbon, Casablanca",
  			 "(GMT +1:00 hour) Brussels, Copenhagen, Madrid, Paris",
  			 "(GMT +2:00) Kaliningrad, South Africa",
  			 "(GMT +3:00) Baghdad, Riyadh, Moscow, St. Petersburg",
  			 "(GMT +3:30) Tehran",
  			 "(GMT +4:00) Abu Dhabi, Muscat, Baku, Tbilisi",
  			 "(GMT +4:30) Kabul",
  			 "(GMT +5:00) Ekaterinburg, Islamabad, Karachi, Tashkent",
  			 "(GMT +5:30) Bombay, Calcutta, Madras, New Delhi",
  			 "(GMT +5:45) Kathmandu",
  			 "(GMT +6:00) Almaty, Dhaka, Colombo",
  			 "(GMT +7:00) Bangkok, Hanoi, Jakarta",
  			 "(GMT +8:00) Beijing, Perth, Singapore, Hong Kong",
  			 "(GMT +9:00) Tokyo, Seoul, Osaka, Sapporo, Yakutsk",
  			 "(GMT +9:30) Adelaide, Darwin",
  			 "(GMT +10:00) Eastern Australia, Guam, Vladivostok",
  			 "(GMT +11:00) Magadan, Solomon Islands, New Caledonia",
  			 "(GMT +12:00) Auckland, Wellington, Fiji, Kamchatka"]
  	clist.each do |c|
      @c1 = Timezone.new
      @c1.timezone = c
      @c1.save
  end
 end
end
