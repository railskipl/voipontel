# == Schema Information
# Schema version: 20100801154548
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password # creates virtual "password" attribute
  attr_accessible :name, :email, :password, :password_confirmation

  has_many :microposts, :dependent => :destroy
  belongs_to :phone
  belongs_to :reference
  has_one :timezone
  # http://railstutorial.org/chapters/modeling-and-viewing-users-one#code:validates_format_of_email
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence => true,
                   :length   => { :maximum => 50 }
  validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }

  # Automatically creates virtual attribute "password_confirmation"
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }

  before_save :encrypt_password
  before_create { sign_in(:user) }

  def feed
    Micropost.where("user_id = ?", id)
  end

  # Return true if user's password matches submitted_password
  def has_password?(submitted_password)
    # Compare encrypted_password with the encrypted version of
    # submitted_password
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
    # Handle password mismatch implicitly (returns nil)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  private

    def encrypt_password
      # new_record? returns true if object has not yet been saved to DB
      # In this case, it ensures that salt is only created once, when user is
      # created.
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    
    def phone_phone_number
    	phone.phone_number if phone
    end
    def phone_phone_number=(phone_number)
    	self.phone = Phone.find_or_create_by_phone_number(phone_number) unless phone_number.blank?
    end
    
    def timezone_timzone
    	timezone_timezone if timezone
    end
    def timezone_timzone=(timezone)
    	self.timezone = Timezone.find_or_create_by_timezone(timezone) unless timezone.blank?
    end
    
    def reference_is_refeered
    	reference_is_refeered if reference
    end
    def reference_is_refeered=(is_refeered)
    	self.reference = Reference.find_or_create_by_is_refeered(is_refeered) unless is_refeered.blank?
    end
    
    def reference_first_name
    	reference.first_name if reference
    end
    def reference_first_name=(first_name)
    	self.reference = Reference.find_or_create_by_first_name(first_name) unless first_name.blank?
    end
    
    def reference_last_name
    	reference.last_name if reference
    end
    def reference_last_name=(last_name)
    	self.reference = Reference.find_or_create_by_last_name(last_name) unless last_name.blank?
    end
    
     def reference_phone_number
    	reference.phone_number if reference
    end
    def reference_phone_number=(phone_number)
    	self.reference = Reference.find_or_create_by_phone_number(phone_number) unless phone_number.blank?
    end
end
