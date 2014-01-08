json.array!(@employer_liability_insurances) do |employer_liability_insurance|
  json.extract! employer_liability_insurance, :title, :synopsis, :price, :company_id
  json.url employer_liability_insurance_url(employer_liability_insurance, format: :json)
end
