json.array!(@product_liability_items) do |product_liability_item|
  json.extract! product_liability_item, :id, :business_nature, :each_accident_limit, :bodily_injury_limit, :property_damage_limit, :aggregate_limit, :started_at, :stopped_at
  json.url product_liability_item_url(product_liability_item, format: :json)
end
