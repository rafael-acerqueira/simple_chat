$(document).on 'turbolinks:load', ->
  $(".add_user").on 'click', (e) =>
    $('#add_user_modal').modal('open')
    $('.add_user_form').attr('action', '/team_users/'+ e.target.id + '/send_invite_team_mail')
    $('#team_user_team_id').val(e.target.id)
    return false

  $('.add_user_form').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'POST'
        dataType: 'json',
        data: {
          team_user: {
            email: $('#team_user_email').val()
            team_id: $('#team_user_team_id').val()
          }
        }
        success: (data, text, jqXHR) ->          
          Materialize.toast('Success in send email to invite User &nbsp;<b>:)</b>', 4000, 'green')
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Problem in send email to invite User &nbsp;<b>:(</b>', 4000, 'red')


    $('#add_user_modal').modal('close')
    return false
