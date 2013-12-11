class CustomerProfile < ActiveRecord::Base
  # association macros
  has_one :user, as: :profile, dependent: :destroy
  belongs_to :park_profile
end
