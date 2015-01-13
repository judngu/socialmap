require "rails_helper"

describe "user deletes an event" do 

  it "should allow the user to pick three other users that are attendees to an event" do
    pending
    user = FactoryGirl.create(:user)
    Attendee1 = FactoryGirl.create(:Attendee)
    Attendee2 = FactoryGirl.create(:Attendee)
    Attendee3 = FactoryGirl.create(:Attendee)

    sign_in(user)
  end
end
