require "rails_helper"

describe "views a user profile" do

  it "should list all events that the user created" do
    user = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event, user: user)

    sign_in(user)
    visit user_path(user)

    expect(page).to have_content(event.name)
    expect(page).to have_content(event.passphrase)
  end

  it "should only show a user profile for the current_user" do
    user = FactoryGirl.create(:user)
    user1 = FactoryGirl.create(:user)

    sign_in(user1)
    visit user_path(user)

    expect(page).to have_content(user1.name)

  end

end
