require "rails_helper"

describe "user edits an event" do 

  it "should update the review when a user fills out edit form" do
    user = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event, user: user)
    sign_in(user)

    visit event_path(event)

    click_on "Edit Event"
    save_and_open_page
    fill_in "Name", with: "Edit"
    click_on "Update Event"

    expect(page).to have_content("Edit")
    expect(page).to have_content("Edit")
  end
end
