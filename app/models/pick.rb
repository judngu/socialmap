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
end
