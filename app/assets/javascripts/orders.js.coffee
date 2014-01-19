#jQuery ->
#  $('form').on 'click', '.remove_fields', (event) ->
#    $(this).prev('input[type=hidden]').val('1')
#    $(this).closest('fieldset').hide()
#    event.preventDefault()
#
#  $('form').on 'click', '.add_fields', (event) ->
#    time = new Date().getTime()
#    regexp = new RegExp($(this).data('id'), 'g')
#    $(this).before($(this).data('fields').replace(regexp, time))
#    event.preventDefault()

#$(document).ready ->
#  $('form').on 'click', '.remove_fields', (event) ->
#    $(this).prev('input[type=hidden]').val('1')
#    $(this).closest('fieldset').hide()
#    event.preventDefault()
#
#  $('form').on 'click', '.add_fields', (event) ->
#    time = new Date().getTime()
#    regexp = new RegExp($(this).data('id'), 'g')
#    $(this).before($(this).data('fields').replace(regexp, time))
#    event.preventDefault()

$(document).on "page:change", ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('.dynamic-fields').hide()
#   $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()
