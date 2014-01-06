json.array!(@public_liability_insurances) do |public_liability_insurance|
  json.extract! public_liability_insurance, :title, :synopsis, :price, :company_id
  json.url public_liability_insurance_url(public_liability_insurance, format: :json)
end
