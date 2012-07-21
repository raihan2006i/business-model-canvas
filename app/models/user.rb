class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    User.find_by_email(data['email']) || User.create(email: data['email'], password: Devise.friendly_token[0, 20])
  end
end