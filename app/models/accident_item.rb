class AccidentItem < ActiveRecord::Base
# EMPLOYEE_NUMBER = [ "less_than_50", "between_50_and_200", "more_than_200" ]
  EMPLOYEE_NUMBER = [ ["less_than_50", 0], ["between_50_and_200", 1], ["more_than_200", 2] ]
  QUOTA = [ ["less_than_50k", 0], ["between_50k_and_300k", 1] ]
  ACCIDENT_MEDICAL = [ ["equal_2k", 0], ["equal_5k", 1], ["equal_10k", 2], ["equal_20k", 3] ]
  HOSPITAL_ALLOWANCE = [ ["20_per_day", 0], ["50_per_day", 1], ["100_per_day", 2] ]

  # association macros
  belongs_to :specific_insurance, class_name: 'AccidentInsurance', foreign_key: 'insurance_id'
  belongs_to :industry
  has_one :line_item, as: :insurance_item, dependent: :destroy
  accepts_nested_attributes_for :line_item, update_only: true

  # validation macros
  validates :insurance_id, presence: true
  validates :industry_id, presence: true
  validates :employee_number, presence: true
  validates :quota, presence: true
  validates :started_at, presence: true
  validates :stopped_at, presence: true

  # instance methods
  def owned_by? owner
    return false unless owner.is_a? User
    line_item.user == owner
  end
end
