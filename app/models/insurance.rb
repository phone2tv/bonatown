class Insurance < ActiveRecord::Base
  # the default scope first (if any)
  scope :healths, lambda { where(profile_type: 'HealthInsurance') }

  # association macros
  belongs_to :company
  belongs_to :profile, polymorphic: true

  # validation macros
  validates :title, :presence => true, length: { in: 4..50 }
  validates :price, numericality: true
  validates :workflow_state, :presence => true
  validates :company_id, :presence => true
end
