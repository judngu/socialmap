class Attendee < ActiveRecord::Base
  has_many :users
  belongs_to :events
end
