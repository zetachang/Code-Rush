class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  has_one :oier , :dependent => :destroy
  validates_uniqueness_of :username, :on => :create, :message => "must be unique"
  devise :database_authenticatable, :registerable, :authentication_keys => [:username]
  #:recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :admin, :username, :email, :password, :password_confirmation, :remember_me
  include Gravtastic
  has_gravatar
  
  def is_oier?
    self.oier ? true : false
  end
end
