jQuery ->
  cities = $('#customer_profile_user_attributes_city').html()
  console.log(cities)
  $('#customer_profile_user_attributes_province').change ->
    province = $('#customer_profile_user_attributes_province :selected').text()
    escaped_province = province.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cities).filter("optgroup[label=#{escaped_province}]").html()
    console.log(options)
    if options
      $('#customer_profile_user_attributes_city').html(options)
      $('#customer_profile_user_attributes_city').change()
      $('#customer_profile_user_attributes_city').show()
#     $('#customer_profile_user_attributes_city').parent().show()
    else
      $('#customer_profile_user_attributes_city').empty()
      options = '<option value="">--城市--</option>'
      $('#customer_profile_user_attributes_city').html(options)
      $('#customer_profile_user_attributes_city').change()
      $('#customer_profile_user_attributes_city').hide()
#     $('#customer_profile_user_attributes_city').parent().hide()

jQuery ->
  districts = $('#customer_profile_user_attributes_district').html()
  console.log(districts)
  $('#customer_profile_user_attributes_city').change ->
    city = $('#customer_profile_user_attributes_city :selected').text()
    escaped_city = city.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(districts).filter("optgroup[label=#{escaped_city}]").html()
    console.log(options)
    if options
      $('#customer_profile_user_attributes_district').html(options)
      $('#customer_profile_user_attributes_district').show()
#     $('#customer_profile_user_attributes_district').parent().show()
    else
      $('#customer_profile_user_attributes_district').empty()
      options = '<option value="">--地区--</option>'
      $('#customer_profile_user_attributes_district').html(options)
      $('#customer_profile_user_attributes_district').hide()
#     $('#customer_profile_user_attributes_district').parent().hide()
