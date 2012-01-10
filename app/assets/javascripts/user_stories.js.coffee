$(document).ready ->

  # tooltips
  $('#dashboard_box .tooltip').twipsy(offset: 5)
  $('#user_story_userlist .tooltip').twipsy(offset: -12)
  $('#userstory_info_box .tooltip').twipsy(offset: 15)

  $('.user_stories_container').delegate '.short_description_link', 'click', ->
    $(this).siblings('.short_description').toggle('slow')
    $(this).siblings('.short_description_link').andSelf().toggle()
    false

  $('.input_advice').focus ->
    if $(this).val() is '' or $(this).val() is $(this).attr('name')
      $(this).val('')

  $('.input_advice').blur ->
    if $(this).val() is ''
      $(this).val($(this).attr('name'))

  $('.input_advice').submit ->
    if $(this).val() is '' or $(this).val() is $(this).attr('name')
      $(this).val('')

  $('.draggable_box').draggable
    revert: "invalid",
    cursor: "move",
    helper: "clone",
    appendTo: "body",
    opacity: 0.5

  $('#box_current_sprint').droppable
    accept: "#box_backlog .user_story_box"
    drop: (event, ui) ->
      user_story_id = ui.draggable.attr("id").split("-")[1]
      $('#current-sprint-loader').css visibility:"visible"
      $.post "user_stories/assign_sprint", { id: user_story_id }, (result) ->
        $('#box_current_sprint .user_stories_container').html(result)
        ui.draggable.remove()
        $('.draggable_box').draggable
          revert: "invalid",
          cursor: "move",
          helper: "clone",
          appendTo: "body",
          opacity: 0.5
        $('#box_current_sprint .user_stories_container').lionbars()
      .error ->
        alert 'The server is not reachable.'
        $('#current-sprint-loader').css visibility:"hidden"
      .complete ->
        $('#current-sprint-loader').css visibility:"hidden"

  $('#box_backlog').droppable
    accept: "#box_current_sprint .user_story_box"
    drop: (event, ui) ->
      user_story_id = ui.draggable.attr("id").split("-")[1]
      $('#backlog-loader').css visibility:"visible"
      $.post "user_stories/unassign_sprint", { id: user_story_id }, (result) ->
        $('#box_backlog .user_stories_container').html(result)
        ui.draggable.remove()
        $('.draggable_box').draggable
          revert: "invalid",
          cursor: "move",
          helper: "clone",
          appendTo: "body",
          opacity: 0.5
        $('#box_backlog .user_stories_container').lionbars()
      .error ->
        alert 'The server is not reachable.'
        $('#backlog-loader').css visibility:"hidden"
      .complete ->
        $('#backlog-loader').css visibility:"hidden"

