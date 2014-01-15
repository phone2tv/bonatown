class QuoterProfile < ActiveRecord::Base
  # association macros
  has_one :user, as: :profile
  accepts_nested_attributes_for :user, update_only: true
end
