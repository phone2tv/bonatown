#jQuery ->
#  cities = $('#customer_profile_city_code').html()
#  console.log(cities)
#  $('#customer_profile_province_code').change ->
#    province = $('#customer_profile_province_code :selected').text()
#    escaped_province = province.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
#    options = $(cities).filter("optgroup[label=#{escaped_province}]").html()
#    console.log(options)
#    if options
#      $('#customer_profile_city_code').html(options)
#      $('#customer_profile_city_code').change()
#      $('#customer_profile_city_code').show()
##     $('#customer_profile_city_code').parent().show()
#    else
#      $('#customer_profile_city_code').empty()
#      options = '<option value="">--城市--</option>'
#      $('#customer_profile_city_code').html(options)
#      $('#customer_profile_city_code').change()
#      $('#customer_profile_city_code').hide()
##     $('#customer_profile_city_code').parent().hide()

#jQuery ->
#  districts = $('#customer_profile_district_code').html()
#  console.log(districts)
#  $('#customer_profile_city_code').change ->
#    city = $('#customer_profile_city_code :selected').text()
#    escaped_city = city.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
#    options = $(districts).filter("optgroup[label=#{escaped_city}]").html()
#    console.log(options)
#    if options
#      $('#customer_profile_district_code').html(options)
#      $('#customer_profile_district_code').show()
##     $('#customer_profile_district_code').parent().show()
#    else
#      $('#customer_profile_district_code').empty()
#      options = '<option value="">--地区--</option>'
#      $('#customer_profile_district_code').html(options)
#      $('#customer_profile_district_code').hide()
##     $('#customer_profile_district_code').parent().hide()
