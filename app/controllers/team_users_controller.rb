class TeamUsersController < ApplicationController
  before_action :set_team_user, only: [:destroy]

  def create
    @team_user = TeamUser.new(team_user_params)
    authorize! :create, @team_user

    respond_to do |format|
      if @team_user.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @team_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :destroy, @team_user
    @team_user.destroy

    respond_to do |format|
      format.json {render json: true }
    end
  end

  def leave_team
    @team_user = TeamUser.find_by(team_id: params[:id], user_id: current_user.id)
    authorize! :destroy, @team_user
    @team_user.destroy
    respond_to do |format|
      format.json {render json: true}
    end
  end

  def send_invite_team_mail
    @user = User.find_by(email: params[:team_user][:email])
    if !@user.present?
      respond_to do |format|
        format.json {render json: false, status: :unprocessable_entity }
      end
    else
      @team = Team.find(params[:team_user][:team_id])
      InviteMailer.invite(@user, @team).deliver_now
    end
  end

  def invite_confirm
    @user = User.find(params[:user_id])
    @team = Team.find(params[:team_id])
  end

  private

  def set_team_user
    @team_user = TeamUser.find_by(params[:user_id], params[:team_id])
  end

  def team_user_params
    user = User.find_by(email: params[:team_user][:email])
    params.require(:team_user).permit(:team_id).merge(user_id: user.id)
  end
end
