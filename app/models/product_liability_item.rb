class ProductLiabilityItem < ActiveRecord::Base
  BUSINESS_NATURE = [ ["manufacturer", 0], ["retailer", 1], ["wholesaler", 2], ["importer", 3], ["exporter", 4] ]

  # association macros
  belongs_to :specific_insurance, class_name: 'ProductLiabilityInsurance', foreign_key: 'insurance_id'
# belongs_to :insurance
  has_one :line_item, as: :insurance_item, dependent: :destroy
  accepts_nested_attributes_for :line_item
end
