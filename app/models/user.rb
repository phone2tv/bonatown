class User < ActiveRecord::Base
  # validation macros
  validates :terms_of_service, :acceptance => true

  # macros from gems
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  rolify

  # instance methods
  def role_name
    return "role.name.broker" if self.has_role? :broker
    return "role.name.customer" if self.has_role? :customer
    return "role.name.moderator" if self.has_role? :moderator
    return "role.name.admin" if self.has_role? :admin
  end
end
