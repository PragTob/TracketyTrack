# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $('.short_description_link').click ->
    $(this).siblings('.short_description').toggle('slow')
    false
  $('.draggable_box').draggable
    revert: "invalid",
    cursor: "move"
  $('#box_current_sprint').droppable
    accept: "#box_backlog .user_story_box"
    drop: (event, ui) ->
      user_story_id = ui.draggable.attr("id").split("-")[1]
      $.post "user_stories/assign_sprint", { id: user_story_id }, (result) ->
        $('#box_current_sprint .user_stories_container').html(result)
        ui.draggable.remove()
        $('.draggable_box').draggable
          revert: "invalid",
          cursor: "move"
  $('#box_backlog').droppable
    accept: "#box_current_sprint .user_story_box"
    drop: (event, ui) ->
      user_story_id = ui.draggable.attr("id").split("-")[1]
      $.post "user_stories/unassign_sprint", { id: user_story_id }, (result) ->
        $('#box_backlog .user_stories_container').html(result)
        ui.draggable.remove()
        $('.draggable_box').draggable
          revert: "invalid",
          cursor: "move"

