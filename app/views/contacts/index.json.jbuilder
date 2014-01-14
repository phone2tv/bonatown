json.array!(@contacts) do |contact|
  json.extract! contact, :id, :name, :card_type, :card_no, :birthday, :gender, :english_name, :mobile, :telephone, :province, :city, :district, :customer_profile_id
  json.url contact_url(contact, format: :json)
end
