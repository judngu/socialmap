require "rails_helper"

describe "user edits an event" do 

  it "should only allow the user who created the event to edit the event" do
    user = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event, user: user)
    sign_in(user)

    visit event_path(event)

    click_on "Edit Event"

    fill_in "Name", with: "Edit"
    click_on "Update Event"

    expect(page).to have_content("Event sucessfully updated.")
    expect(page).to have_content("Edit")
  end

  it "should not allow other users to edit the event" do
    user1 = FactoryGirl.create(:user)
    event1 = FactoryGirl.create(:event, user: user1)
    user2 = FactoryGirl.create(:user)

    sign_in(user2)
    visit event_path(event1)

    expect(page).not_to have_content("Edit Event")
  end



end
