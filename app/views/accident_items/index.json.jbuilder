json.array!(@accident_items) do |accident_item|
  json.extract! accident_item, :id, :accident_insurance_id, :industry_id, :employee_number
  json.url accident_item_url(accident_item, format: :json)
end
