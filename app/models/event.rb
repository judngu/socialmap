class Event < ActiveRecord::Base
  belongs_to :user
  has_many :attendees
  has_many :picks
  has_many :users, through: :attendees

  validates :name, presence: true
  validates :user_id, presence:true
  validates :question, presence: true

  def first_pick=(value)
  end

  def second_pick=(value)
  end

  def third_pick=(value)
  end
end
