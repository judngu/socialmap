class Pick < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :picked_user, class_name: "User"

  def self.count_picks(event)
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

  def nodes(event)
    nodes = []
    event.users.each do |user|
      user_entry = Hash.new
      user_entry["name"] = user.name
      user_entry["group"] = rand(50)
      nodes << user_entry
    end
    nodes
  end
end
