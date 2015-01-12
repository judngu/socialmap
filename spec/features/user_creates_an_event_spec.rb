require "rails_helper"

describe "user create an event" do 

  it "should allow users to create an event they can manage" do
    user = FactoryGirl.create(:user)
    sign_in(user)

    visit new_event_path
    fill_in "Name", with: "My Awesome Event"
    fill_in "Location", with: "Space"
    fill_in "City", with: "Rocketville"
    fill_in "State", with: "MA"
    fill_in "Question", with: "Who do you think is best at this meeting?"
    fill_in "Passphrase", with: "This is my secret"
    fill_in "Description", with: "This event weeds out how awesome people are"
    click_on "Create Event"

    expect(page).to have_content("Event Sucessfully Created")
    expect(page).to have_content("My Awesome Event")
  end

end
