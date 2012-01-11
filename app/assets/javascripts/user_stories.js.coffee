makeJQuserStoryButtons = ->
  $(".pause_button").button({
    icons: {
      primary: "ui-icon-pause"
    },
    text: false
  })
  $(".continue_button").button({
    icons: {
      primary: "ui-icon-play"
    },
    text: false
  })
  $(".complete_button").button({
    icons: {
      primary: "ui-icon-check"
    }
  })
  $(".restart_button").button({
    icons: {
      primary: "ui-icon-play"
    }
  })
  $(".start_button").button({
    icons: {
      primary: "ui-icon-play"
    }
  })

makeDraggable = (className) ->
  $(className).draggable
    revert: "invalid",
    cursor: "move",
    helper: "clone",
    appendTo: "body",
    opacity: 0.5

postAssign = (user_story_id, user_story_box) ->
  $.post 'user_stories/assign_sprint', { id: user_story_id }, (result) ->
        $('#box_current_sprint .user_stories_container').html(result)
        makeDraggable '.draggable_box'
        $('#box_current_sprint .user_stories_container').lionbars()
      .error ->
        alert 'The server is not reachable.'
        $('#current-sprint-loader').css visibility:"hidden"
      .complete ->
        user_story_box.remove()
        $('#current-sprint-loader').css visibility:"hidden"

postUnassign = (user_story_id, user_story_box) ->
  $.post 'user_stories/unassign_sprint', { id: user_story_id }, (result) ->
      $('#box_backlog .user_stories_container').html(result)
      makeDraggable '.draggable_box'
      $('#box_backlog .user_stories_container').lionbars()
    .error ->
      alert 'The server is not reachable.'
      $('#backlog-loader').css visibility:"hidden"
    .complete ->
      user_story_box.remove()
      $('#backlog-loader').css visibility:"hidden"

$(document).ready ->
  # tooltips
  $('#dashboard_box .tooltip').twipsy(offset: 5)
  $('#user_story_userlist .tooltip').twipsy(offset: -12)
  $('#userstory_info_box .tooltip').twipsy(offset: 15)

  #user story buttons
  makeJQuserStoryButtons()

  # show and hide user story description
  $('.user_stories_container').delegate '.short_description_link', 'click', ->
    $(this).parent().parent().find('.short_description').toggle('slow')
    $(this).siblings('.short_description_link').andSelf().toggle()
    false

  makeDraggable '.draggable_box'

  # assign/unassign user stories using drag and drop
  $('#box_current_sprint').droppable
    accept: "#box_backlog .user_story_box"
    drop: (event, ui) ->
      user_story_id = ui.draggable.attr("id").split("-")[1]
      $('#current-sprint-loader').css visibility:"visible"
      postAssign user_story_id, ui.draggable

  $('#box_backlog').droppable
    accept: "#box_current_sprint .user_story_box"
    drop: (event, ui) ->
      user_story_id = ui.draggable.attr("id").split("-")[1]
      $('#backlog-loader').css visibility:"visible"
      postUnassign user_story_id, ui.draggable

  # assign/unassign user stories using the transfer button
  $('#box_backlog').delegate '.transferbutton', 'click', ->
    user_story_id = $(this).attr("id").split("-")[1]
    $('#current-sprint-loader').css visibility:"visible"
    box_id = '#userstory-'+user_story_id
    postAssign user_story_id, $(box_id)

  $('#box_current_sprint').delegate '.transferbutton', 'click', ->
    user_story_id = $(this).attr("id").split("-")[1]
    $('#backlog-loader').css visibility:"visible"
    box_id = '#userstory-'+user_story_id
    postUnassign user_story_id, $(box_id)

