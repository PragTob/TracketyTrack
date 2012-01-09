# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

  $('#userstory_info_box').delegate '.ui-icon-minus', 'click', ->
    $('#userstory_info_box').animate height: $('.ui-tabs-nav').height(), 1000
    icon = $('#userstory_info_box .ui-icon-minus')
    icon.addClass 'ui-icon-plus'
    icon.removeClass 'ui-icon-minus'
    false

  $('#userstory_info_box').delegate '.ui-icon-plus', 'click', ->
    $('#userstory_info_box').animate height: 150, 1000
    icon = $('#userstory_info_box .ui-icon-plus')
    icon.addClass 'ui-icon-minus'
    icon.removeClass 'ui-icon-plus'
    false

