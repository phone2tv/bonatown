class EmployerLiabilityInsurance < Insurance
  has_many :specific_items, class_name: 'EmployerLiabilityItem'
# has_many :public_liability_items
end
