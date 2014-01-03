class AccidentItem < ActiveRecord::Base
# EMPLOYEE_NUMBER = [ "less_than_50", "between_50_and_200", "more_than_200" ]
  EMPLOYEE_NUMBER = [ ["less_than_50", 1], ["between_50_and_200", 2], ["more_than_200", 3] ]

  # association macros
  belongs_to :specific_insurance, class_name: 'AccidentInsurance', foreign_key: 'accident_insurance_id'
  belongs_to :industry
end
