json.array!(@companies) do |company|
  json.extract! company, :name, :website, :aboutme
  json.url company_url(company, format: :json)
end
