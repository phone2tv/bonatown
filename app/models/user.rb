class User < ActiveRecord::Base
  # the default scope first (if any)
  scope :admins, lambda { where(profile_type: 'AdminProfile') }
  scope :moderators, lambda { where(profile_type: 'ModeratorProfile') }
  scope :managers, lambda { where(profile_type: 'ManagerProfile') }
  scope :quoters, lambda { where(profile_type: 'QuoterProfile') }
  scope :parks, lambda { where(profile_type: 'ParkProfile') }
  scope :customers, lambda { where(profile_type: 'CustomerProfile') }

  # attributes related macros
  attr_accessor :login
# attr_accessor :terms_of_service

  # association macros
  belongs_to :profile, polymorphic: true

  # validation macros
# validates :terms_of_service, :presence => true, :acceptance => true, on: :create
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
    return "role.name.park" if self.has_role? :park
    return "role.name.quoter" if self.has_role? :quoter
    return "role.name.manager" if self.has_role? :manager
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
