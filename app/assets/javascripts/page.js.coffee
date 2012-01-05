# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
adjustBoxHeight = ->
 boxHeight = window.innerHeight-300
 boxHeight = 300 if boxHeight<300
 containerHeight = boxHeight - 50
 $(".userstory_box").css height: boxHeight
 $(".user_stories_container").css height: containerHeight

$(document).ready(
  () ->
   $(".user_stories_container").lionbars()
   adjustBoxHeight()
)

