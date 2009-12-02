require 'digest/sha1'

class User < ActiveRecord::Base
  validates_presence_of :login_name
  validates_uniqueness_of :login_name

	validates_presence_of :nick_name
	validates_uniqueness_of :nick_name
	
  attr_accessor :password_confirmation
  validates_confirmation_of :password
  
  validate :password_non_blank

  ROLE_LIST = [
    ["new", 0],
    ["employee", 10],
    ["admin", 100]
  ]
  def role
    r = ROLE_LIST.find {|ro| ro[1]==self.role_id }
    r ? r[0] : '未定义'
  end

  #password is a virtual attribute
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end
  
  private
  
  def password_non_blank
    errors.add(:password, "Missing password") if hashed_password.blank?
  end
  
  def self.encrypted_password(password, salt)
    string_to_hash = password + "coolpur" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
  
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
  def self.authenticate(login_name,password)
	  user = self.find_by_login_name(login_name)
	  if user
		  expected_password = encrypted_password(password,user.salt)
		  if user.hashed_password!=expected_password
			  user= nil
		  end
		  user
	  end
  end
  
  
end

