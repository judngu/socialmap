class Pick < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :picked_user, class_name: "User"

  def self.node_weights(event)
    user_scores = Hash.new(0)

    event.picks.each do |pick|
      user_scores[pick.picked_user.name] += pick.value
    end

    user_scores
  end

  def self.nodes(event)
    event.users.map do |user|
      { "name" => user.name, "group" => random_color_group }
    end
  end

  def self.node_index(nodes)
    node_index = Hash.new

    nodes.each_with_index do |user, n|
      name = user["name"]
      node_index["#{name}"] = n
    end

    node_index
  end

  def self.links(event, node_index)
    event.picks.map do |pick|
      {
        "source" => node_index[pick.user.name],
        "target" => node_index[pick.picked_user.name],
        "value" => 1
      }
    end
  end

  private

  def self.random_color_group
    rand(50)
  end
end
