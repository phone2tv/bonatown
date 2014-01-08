json.array!(@product_liability_insurances) do |product_liability_insurance|
  json.extract! product_liability_insurance, :title, :synopsis, :price, :company_id
  json.url product_liability_insurance_url(product_liability_insurance, format: :json)
end
