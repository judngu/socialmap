require "rails_helper"

describe "user deletes an event" do 

  it "should allow the user to pick three other users that are attendees to an event" do
    event = FactoryGirl.create(:event)
    user = FactoryGirl.create(:user)
    user1 = FactoryGirl.create(:user)
    #attendee = FactoryGirl.create(:attendee, user_id: user.id, event_id: event.id)
    attendee1 = FactoryGirl.create(:attendee, user_id: user1.id, event_id: event.id)

    sign_in(user)
    visit root_path
    fill_in "passphrase", with: event.passphrase
    click_on "Create Attendee"
    save_and_open_page
    select attendee1.user.name, from: "pick"

    expect(page).to have_content("test")

  end
end
