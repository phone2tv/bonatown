class EmployerLiabilityItem < ActiveRecord::Base
  BUSINESS_NATURE = [ ["social_groups", 0], ["institutions", 1], ["government_agencies", 2], ["school", 3], ["business", 4], ["restaurant", 5], ["financial_enterprise", 6], ["entertainment", 7], ["manufacture", 8] ]

  # association macros
  belongs_to :specific_insurance, class_name: 'EmployerLiabilityInsurance', foreign_key: 'insurance_id'
# belongs_to :insurance
  has_one :line_item, as: :insurance_item, dependent: :destroy
  accepts_nested_attributes_for :line_item, update_only: true
  has_many :employer_liability_employees, dependent: :destroy
  accepts_nested_attributes_for :employer_liability_employees, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  # validation macros
  validates :insurance_id, presence: true
  validates :business_nature, presence: true

  # instance methods
  def owned_by? owner
    return false unless owner.is_a? User
    line_item.user == owner
  end
end
