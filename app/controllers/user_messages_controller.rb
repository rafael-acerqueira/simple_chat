class UserMessagesController < ApplicationController

  def create
    @user_messages = CreateUserMessage.new(user_message_params)

    respond_to do |format|
      if @user_messages.create
        format.json { render json: true, status: :created }
      else
        format.json { render json: false, status: :unprocessable_entity }
      end
    end
  end

  private
  def user_message_params
    params.require(:user_message).permit(:channel_id, :user_id)
  end
end
