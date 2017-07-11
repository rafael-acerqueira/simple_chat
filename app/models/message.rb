class Message < ApplicationRecord
  belongs_to :messagable, polymorphic: true
  belongs_to :user
  has_many :user_messages, dependent: :destroy
  has_many :users, through: :user_messages
  validates_presence_of :body, :user

  after_create_commit {MessageBroadcastJob.perform_later self}
  after_create_commit :view_message

  def view_message
    UserMessage.create(user: self.user, message: self)
  end
end
