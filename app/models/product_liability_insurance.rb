class ProductLiabilityInsurance < Insurance
  has_many :specific_items, class_name: 'ProductLiabilityItem'
# has_many :public_liability_items
end
