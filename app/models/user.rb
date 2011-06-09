class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  has_one :oier
  devise :database_authenticatable, :registerable, :authentication_keys => [:username]
  #:recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :admin, :username, :email, :password, :password_confirmation, :remember_me
end
