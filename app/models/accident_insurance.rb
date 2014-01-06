class AccidentInsurance < Insurance
  has_many :specific_items, class_name: 'AccidentItem'
# has_many :accident_items
end
=begin
class AccidentInsurance < ActiveRecord::Base
  # association macros
  has_one :insurance, as: :profile, dependent: :destroy
  accepts_nested_attributes_for :insurance
  has_many :specific_items, class_name: 'AccidentItem'
# has_many :accident_items
end
=end
