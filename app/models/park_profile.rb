class ParkProfile < ActiveRecord::Base
  # association macros
  has_one :user, as: :profile
  accepts_nested_attributes_for :user, update_only: true
  has_many :customer_profiles, dependent: :nullify
  belongs_to :company
end
