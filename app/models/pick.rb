class Pick < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  def self.count_picks(event)
  end
end
