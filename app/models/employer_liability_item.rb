class EmployerLiabilityItem < ActiveRecord::Base
  BUSINESS_NATURE = [ ["manufacturer", 0], ["retailer", 1], ["wholesaler", 2], ["importer", 3], ["exporter", 4] ]

  # association macros
  belongs_to :specific_insurance, class_name: 'EmployerLiabilityInsurance', foreign_key: 'insurance_id'
# belongs_to :insurance
  has_one :line_item, as: :insurance_item, dependent: :destroy
  accepts_nested_attributes_for :line_item, update_only: true
# has_many :insured_products, dependent: :destroy
# accepts_nested_attributes_for :insured_products, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  # validation macros
  validates :insurance_id, presence: true
  validates :business_nature, presence: true

  # instance methods
  def owned_by? owner
    return false unless owner.is_a? User
    line_item.user == owner
  end
end
