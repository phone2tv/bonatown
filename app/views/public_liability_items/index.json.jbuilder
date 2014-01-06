json.array!(@public_liability_items) do |public_liability_item|
  json.extract! public_liability_item, :id, :insurance_id, :business_place, :business_type, :with_fire_control, :with_security_measure
  json.url public_liability_item_url(public_liability_item, format: :json)
end
