require "rails_helper"

describe "user joins an event as an attendee" do 
  
  it "should have a link to the index to write in the passphrase to join event" do
    user = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event)
    sign_in(user)

    visit root_path
    fill_in "passphrase", with: event.passphrase
    click_on "Join"

    expect(page).to have_content("#{event.name}")
    expect(Attendee.count).to eq 1
  end

  it "should prompt the user to sign in if not signed in" do
    event = FactoryGirl.create(:event)

    visit root_path
    fill_in "passphrase", with: event.passphrase
    click_on "Join"

    expect(page).to have_content "You need to sign in or sign up before continuing."
    expect(Attendee.count).to eq 0
  end

  it "should throw an error when an invalid passphrase is entered" do
    user = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event)
    sign_in(user)

    visit root_path
    fill_in "passphrase", with: "test"
    click_on "Join"

    expect(page).to have_content "Event does not exist"
    expect(Attendee.count).to eq 0
  end

end
