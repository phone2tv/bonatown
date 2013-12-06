json.array!(@health_insurances) do |health_insurance|
  json.extract! health_insurance, :body
  json.url health_insurance_url(health_insurance, format: :json)
end
