provinceChange = (province_id, city_id) ->
  cities = $(city_id).html()
# console.log(cities)
  $(province_id).change ->
    province = $(province_id + ' :selected').text()
    escaped_province = province.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cities).filter("optgroup[label=#{escaped_province}]").html()
#   console.log(options)
    if options
      $(city_id).html(options)
      $(city_id).change()
#     $(city_id).show()
#     $(city_id).parent().show()
    else
      $(city_id).empty()
      options = '<option value="">--城市--</option>'
      $(city_id).html(options)
      $(city_id).change()
#     $(city_id).hide()
#     $(city_id).parent().hide()

cityChange = (city_id, district_id) ->
  districts = $(district_id).html()
# console.log(districts)
  $(city_id).change ->
    city = $(city_id + ' :selected').text()
    escaped_city = city.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(districts).filter("optgroup[label=#{escaped_city}]").html()
#   console.log(options)
    if options
      $(district_id).html(options)
#     $(district_id).show()
#     $(district_id).parent().show()
    else
      $(district_id).empty()
      options = '<option value="">--地区--</option>'
      $(district_id).html(options)
#     $(district_id).hide()
#     $(district_id).parent().hide()

#$(document).ready ->
# provinceChange('#customer_profile_user_attributes_province', '#customer_profile_user_attributes_city')
# cityChange('#customer_profile_user_attributes_city', '#customer_profile_user_attributes_district')
#  provinceChange('#customer_profile_province_code', '#customer_profile_city_code')
#  cityChange('#customer_profile_city_code', '#customer_profile_district_code')

$(document).on "page:change", ->
  provinceChange('#customer_profile_province_code', '#customer_profile_city_code')
  cityChange('#customer_profile_city_code', '#customer_profile_district_code')
  $('#customer_profile_province_code').change()

  provinceChange('.select-province', '.select-city')
  cityChange('.select-city', '.select-district')
  $('.select-province').change()
