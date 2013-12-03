class User < ActiveRecord::Base
  # attributes related macros
  attr_accessor :login

  # association macros
  belongs_to :profile, polymorphic: true

  # validation macros
  validates :terms_of_service, :presence => true, :acceptance => true, on: :create

  # validation
  validates :username, :presence => true, uniqueness: true, length: { in: 4..20 }

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

  # class methods
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
    # where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
