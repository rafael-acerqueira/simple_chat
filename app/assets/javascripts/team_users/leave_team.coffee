$(document).on 'turbolinks:load', ->
  $('body').on 'click', 'a.leave_team', (e) ->
    $('#leave_team_modal').modal('open')
    $('.remove_team_user_form').attr('action', '/team_users/' + e.target.id + '/leave_team')
    $('#user_remove_id').val(e.target.id)
    return false

  $('.remove_team_user_form').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'DELETE'
        dataType: 'json',
        data: {team_id: $(".team_id").val()}
        success: (data, text, jqXHR) ->
          $('.user_' + $('#user_remove_id').val()).remove()
          $(location).attr('href','/');
          Materialize.toast('Success in remove User &nbsp;<b>:)</b>', 4000, 'green')
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Problem to remove User &nbsp;<b>:(</b>', 4000, 'red')

    $('#leave_team_modal').modal('close')
    return false
