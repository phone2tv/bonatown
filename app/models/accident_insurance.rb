class AccidentInsurance < ActiveRecord::Base
  # association macros
  has_one :insurance, as: :profile, dependent: :destroy
  accepts_nested_attributes_for :insurance
end
