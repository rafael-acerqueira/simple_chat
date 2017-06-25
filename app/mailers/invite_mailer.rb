class InviteMailer < ActionMailer::Base

  def invite(user, team)
    @team = team
    @user = user
    mail subject: 'Convite para Time',
      from: 'naoresponder@Onebitchat.com',
      to: @user.email
  end
end
