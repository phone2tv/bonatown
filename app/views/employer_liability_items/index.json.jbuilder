json.array!(@employer_liability_items) do |employer_liability_item|
  json.extract! employer_liability_item, :id, :business_nature, :bodily_injury_limit, :medical_expenses_limit, :litigation_costs_limit, :within_period_aggregate_limit, :deductibles, :each_accident_limit, :each_accident_bodily_injury_limit, :aggregate_limit, :property_deductibles, :employee_number, :effective_date, :termination_date
  json.url employer_liability_item_url(employer_liability_item, format: :json)
end
