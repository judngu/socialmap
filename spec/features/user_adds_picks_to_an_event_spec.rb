require "rails_helper"

describe "user deletes an event" do 

  it "should allow the user to pick three other users that are attendees to an event" do
    event = FactoryGirl.create(:event)
    user = FactoryGirl.create(:user)
    user1 = FactoryGirl.create(:user)
    
    attendee1 = FactoryGirl.create(:attendee, user_id: user1.id, event_id: event.id)

    sign_in(user)
    visit root_path

    fill_in "passphrase", with: event.passphrase
    click_on "Create Attendee"
    within(:css, "#connection.value1") do
      select attendee1.user.name, from: "pick[picked_user_id]"
      click_on "Create Pick"
    end
    expect(Pick.count).to eq 1

  end
end
