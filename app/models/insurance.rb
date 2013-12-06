class Insurance < ActiveRecord::Base
  # the default scope first (if any)
  scope :healths, lambda { where(profile_type: 'HealthInsurance') }

  # association macros
  belongs_to :company
  belongs_to :profile, polymorphic: true
end
