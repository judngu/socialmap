require "rails_helper"

describe "views a sociogram" do
  
  it "should give a list of ranks" do

    user = FactoryGirl.create(:user)
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    user3 = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event, user: user)
    pick1 = FactoryGirl.create(:pick, user_id: user1.id, event_id: event.id)
    pick1 = FactoryGirl.create(:pick, user_id: user2.id, event_id: event.id)
    pick1 = FactoryGirl.create(:pick, user_id: user3.id, event_id: event.id)
    sign_in(user)
    
    visit event_path(event)
    save_and_open_page
    click_on "View Map"

    expect(page).to have_content(pick1.picked_user)
  end
end
