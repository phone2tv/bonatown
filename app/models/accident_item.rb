class AccidentItem < ActiveRecord::Base
# EMPLOYEE_NUMBER = [ "less_than_50", "between_50_and_200", "more_than_200" ]
  EMPLOYEE_NUMBER = [ ["less_than_50", 1], ["between_50_and_200", 2], ["more_than_200", 3] ]
  QUOTA = [ ["less_than_50k", 1], ["between_50k_and_300k", 2] ]

  # association macros
  belongs_to :specific_insurance, class_name: 'AccidentInsurance', foreign_key: 'accident_insurance_id'
  belongs_to :industry

  validates :accident_insurance_id, presence: true
  validates :industry_id, presence: true
  validates :employee_number, presence: true
  validates :quota, presence: true
  validates :started_at, presence: true
  validates :stopped_at, presence: true
end
