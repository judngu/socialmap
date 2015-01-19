class Pick < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :picked_user, class_name: "User"

  def self.node_weights(event)
    list = []
    event.picks.each do |p|
      list << { p.picked_user.name => p.value }
    end

    results = Hash.new(0)
    list.each do |hash|
      hash.each do |key, value|
        results[key] += value
      end
    end
    results
  end

  def self.nodes(event)
    nodes = []
    event.users.each do |user|
      user_entry = Hash.new
      user_entry["name"] = user.name
      user_entry["group"] = rand(50)
      nodes << user_entry
    end
    nodes
  end

  def self.node_index(nodes)
    n = 0
    node_index = Hash.new
    nodes.each do |user|
      name = user["name"]
      node_index["#{name}"] = n
      n += 1
    end
    node_index
  end

  def self.links(event, node_index)
    links = []
    picks = event.picks
    picks.each do |pick|
      link = Hash.new
      link["source"] = node_index[pick.user.name]
      link["target"] = node_index[pick.picked_user.name]
      link["value"] = 1
      links << link
    end
    links
  end
end
