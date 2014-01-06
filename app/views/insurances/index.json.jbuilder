json.array!(@insurances) do |insurance|
  json.extract! insurance, :id, :title, :synopsis, :price, :aasm_state, :type, :company_id, :image, :target, :feature, :benefit
  json.url insurance_url(insurance, format: :json)
end
