class CustomerProfile < ActiveRecord::Base
  # association macros
  has_one :user, as: :profile, dependent: :destroy
  accepts_nested_attributes_for :user, update_only: true
  belongs_to :park_profile
end
