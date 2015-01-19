class Pick < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :picked_user, class_name: "User"


end
