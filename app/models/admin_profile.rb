class AdminProfile < ActiveRecord::Base
  # association macros
  has_one :user, as: :profile, dependent: :destroy

  # validation
  validates :nickname, :presence => true, :length => { :maximum => 20 }
end
