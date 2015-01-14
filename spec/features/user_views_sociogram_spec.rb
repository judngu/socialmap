require "rails_helper"

describe "views a sociogram" do
  it "should give a list of ranks" do

    user = FactoryGirl.create(:user)
    user1 = FactoryGirl.create(:user)
    
    event = FactoryGirl.create(:event, user: user)
    pick1 = FactoryGirl.create(:pick)
    pick1 = FactoryGirl.create(:pick)
    pick1 = FactoryGirl.create(:pick)

    visit event_path(event)

    click_on "view map"

    expect(page).to have_content(pick1.picked_user.name)
  end
end
