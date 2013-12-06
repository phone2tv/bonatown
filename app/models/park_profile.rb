class ParkProfile < ActiveRecord::Base
  # association macros
  has_one :user, as: :profile, dependent: :destroy
  has_many :customer_profiles, dependent: :nullify
end
