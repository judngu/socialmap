class Event < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :user_id, presence:true
  validates :question, presence: true
end
