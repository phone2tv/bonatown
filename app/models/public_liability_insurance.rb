class PublicLiabilityInsurance < Insurance
  has_many :specific_items, class_name: 'PublicLiabilityItem'
# has_many :public_liability_items
end
