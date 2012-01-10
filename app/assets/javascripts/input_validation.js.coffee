$(document).ready ->
  $('.input_advice').focus ->
    if $(this).val() is $(this).attr('title')
      $(this).val('')

  $('.input_advice').blur ->
    if $(this).val() is ''
      $(this).val($(this).attr('title'))

  $('.input_advice_form').submit ->
    fields = $(this).find('.input_advice')
    for field in fields
      if $(field).attr('value') is $(field).attr('title')
        $(field).attr 'value', ''

  $('.input_numeric').blur ->
    regex = /^[0-9]*$/
    if not regex.test $(this).val()
      $(this).siblings('.numeric_validation_error').toggle()

  $('.input_numeric').focus ->
    error_message = $(this).siblings('.numeric_validation_error')
    if error_message.css('display') is 'block'
      error_message.toggle()

  $('.input_numeric_small').blur ->
    regex = /^[0-9]*$/
    if not regex.test $(this).val()
      $(this).addClass 'invalid_input'
      $(this).twipsy 'show'

  $('.input_numeric_small').focus ->
    if $(this).hasClass 'invalid_input'
      $(this).removeClass 'invalid_input'
      $(this).twipsy 'hide'

  $('.input_numeric_small').twipsy fallback: 'Has to be numeric!', offset: -5, trigger: 'manual'

