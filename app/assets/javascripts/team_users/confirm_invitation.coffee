$(document).on 'turbolinks:load', ->
  $("#confirm_invitation").on 'click', (e) =>
    $.ajax '/team_users',
        type: 'POST'
        dataType: 'json',
        data: {
          team_user: {
            email: $('#user_email').val()
            team_id: $('#team_id').val()
          }
        }
        success: (data, text, jqXHR) ->
          $(location).attr('href','/');
          Materialize.toast('Confirm invite User Successfully &nbsp;<b>:)</b>', 4000, 'green')
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Problem in confirm invite User &nbsp;<b>:(</b>', 4000, 'red')

    return false;
