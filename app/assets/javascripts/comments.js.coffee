# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $('.comment_content_box').mouseover ->
    buttons = $(this).children('.button_to').find('div').children(".delete_button")
    if buttons.length >= 1
      buttons[0].style.visibility='visible'

$(document).ready ->
    $('.comment_content_box').mouseout ->
      buttons = $(this).children('.button_to').find('div').children(".delete_button")
      if buttons.length >= 1
        buttons[0].style.visibility='hidden'

