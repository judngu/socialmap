require "rails_helper"

describe "user deletes an event" do 

  it "should only allow the user who created the event to delete the event" do
    user = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event, user: user)
    sign_in(user)

    visit event_path(event)

    click_on "Delete Event"

    expect(page).to have_content("Event sucessfully deleted.")
    expect(Event.count).to eq 0

  end
end
