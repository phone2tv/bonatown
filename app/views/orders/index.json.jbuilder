json.array!(@orders) do |order|
  json.extract! order, :aasm_state, :address
  json.url order_url(order, format: :json)
end
