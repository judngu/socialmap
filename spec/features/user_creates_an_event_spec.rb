require "rails_helper"

describe "user create an event" do 

  it "should allow users to create an event they can manage" do
    user = FactoryGirl.create(:user)
    sign_in(user)

    visit new_event_path
    fill_in "Name", with: "My Awesome Event"
    fill_in "Address", with: "123 Space St."
    fill_in "Location", with: "Space"
    fill_in "City", with: "Rocketville"
    fill_in "State", with: "MA"
    fill_in "Question", with: "Who do you think is best at this meeting?"
    fill_in "Passphrase", with: "This is my secret password"
    fill_in "Description", with: "This event weeds out people who are underpreforming"
    click_on "Create Event"

    expect(page).to have_content("Event Sucessfully Created")
    expect(page).to have_content("123 Space St.")
    expect(page).to have_content("Space")
    expect(page).to have_content("Rocketville")
    expect(page).to have_content("MA")
    expect(page).to have_content("Who do you think is best at this meeting?")
    expect(page).to have_content("This event weeds out people who are underpreforming")
  end

  it "should not allow an event with missing information to be created" do
    user = FactoryGirl.create(:user)
    sign_in(user)

    visit new_event_path
    click_on "Create Event"

    expect(page).to have_content("Name can't be blank")
  end
end
