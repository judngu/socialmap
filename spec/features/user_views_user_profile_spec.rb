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

end
