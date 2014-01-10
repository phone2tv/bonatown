class AdminProfile < ActiveRecord::Base
  # association macros
  has_one :user, as: :profile, dependent: :destroy
  accepts_nested_attributes_for :user, update_only: true

  # validation
# validates :nickname, :presence => true, :length => { :maximum => 20 }
end
