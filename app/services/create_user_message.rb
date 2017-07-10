class CreateUserMessage

  attr_reader :channel_id, :user_id

  def initialize(params)
    @channel_id = params[:channel_id]
    @user_id = params[:user_id]
  end

  def create
    UserMessage.transaction do
      channel = Channel.find(channel_id)
      messages = channel.messages
      messages.each do |message|
        UserMessage.find_or_create_by(user_id: user_id, message_id: message.id)
      end
    end
  end
end
