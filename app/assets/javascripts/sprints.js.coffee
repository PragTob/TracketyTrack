# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

minimize = (count, interval) ->
  $('#userstory_details_box').queue 'myQueue', ->
    $(this).delay count * 50, 'myQueue'
    $(this).height($('#userstory_details_box').height() - interval)
  .dequeue 'myQueue'

maximize = (count, interval) ->
  $('#userstory_details_box').queue 'myQueue', ->
    $(this).delay count * 50, 'myQueue'
    $(this).height($('#userstory_details_box').height() + interval)
  .dequeue 'myQueue'

$(document).ready ->

  $('#userstory_details_box').delegate '.ui-icon-minus', 'click', ->
    interval = 10
    endNumber = ($('#userstory_details_box').height() - $('.ui-tabs-nav').height()) / interval
    minimize(count, interval) for count in [0..endNumber]
    $(this).addClass 'ui-icon-plus'
    $(this).removeClass 'ui-icon-minus'
    false

  $('#userstory_details_box').delegate '.ui-icon-plus', 'click', ->
    interval = 10
    endNumber = (150 - $('.ui-tabs-nav').height()) / interval
    maximize(count, interval) for count in [0..endNumber]
    $(this).addClass 'ui-icon-minus'
    $(this).removeClass 'ui-icon-plus'
    false

