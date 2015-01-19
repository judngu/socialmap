class User < ActiveRecord::Base
  has_many :events
  has_many :picks
  has_many :attendees

  validates :name, presence: true

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  def self.all_except(user)
    where.not(id: user)
  end
end
