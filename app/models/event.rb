class Event < ActiveRecord::Base
  belongs_to :user
  has_many :attendees
  has_many :picks
  has_many :users, through: :attendees

  validates :name, presence: true
  validates :user, presence:true
  validates :question, presence: true
  validates :passphrase, presence: true, uniqueness: true

  def other_attendees(user)
  	users.all_except(user)
  end

  def sociograph
    { nodes: grouped_users, links: user_links }
  end

  def self.random_passphrase
    ('a'..'z').to_a.shuffle[0, 10].join.upcase
  end

  private

  def user_weights
    weights = Hash.new(0)

    picks.each do |pick|
      weights[pick.picked_user.name] += pick.value
    end

    weights
  end

  def grouped_users
    users.map do |user|
      { "name" => user.name, "group" => random_color_group }
    end
  end

  def users_index
    @users_index ||= calculate_users_index
  end

  def calculate_users_index
    user_index = Hash.new

    grouped_users.each_with_index do |user, i|
      name = user["name"]
      user_index["#{name}"] = i
    end

    user_index
  end

  def user_links
    picks.map do |pick|
      {
        "source" => users_index[pick.user.name],
        "target" => users_index[pick.picked_user.name],
        "value" => 1
      }
    end
  end

  def random_color_group
    rand(50)
  end
end
