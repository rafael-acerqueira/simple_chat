class User < ApplicationRecord
  has_many :teams
  has_many :messages
  has_many :talks
  has_many :team_users, dependent: :destroy
  has_many :member_teams, through: :team_users, :source => :team

  has_many :user_messages, dependent: :destroy
  has_many :read_messages, through: :user_messages, :source => :message

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 def my_teams
   teams + member_teams
 end

 def unread_messages?(channel_id)   
   channel = Channel.find(channel_id)
   unread_messages = self.read_messages.where(messagable_id: channel_id).count
   channel_messages = channel.messages.count
   unread_messages != channel_messages
 end
end
