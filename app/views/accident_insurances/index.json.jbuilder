json.array!(@accident_insurances) do |accident_insurance|
  json.extract! accident_insurance, :title, :synopsis, :price, :company_id
  json.url accident_insurance_url(accident_insurance, format: :json)
end
