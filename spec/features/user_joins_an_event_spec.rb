require "rails_helper"

describe "user joins an event as an attendee" do 
  it "should have a link to the index to write in the passphrase to join event" do
    pending 
    user = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event)
    sign_in(user)

    visit root_path
    fill_in "Passphrase", with: event.passphrase
    click_on "Submit"

    expect(page).to have_content("#{event.name}")
  end
end
