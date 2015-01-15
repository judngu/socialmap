require "rails_helper"

describe "views a sociogram" do

  it "should give a list of ranks" do
    user = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event, user: user)

    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    user3 = FactoryGirl.create(:user)
    user4 = FactoryGirl.create(:user)
    user5 = FactoryGirl.create(:user)

    attendee1 = FactoryGirl.create(:attendee, user_id: user1.id, event_id: event.id)
    attendee2 = FactoryGirl.create(:attendee, user_id: user2.id, event_id: event.id)
    attendee3 = FactoryGirl.create(:attendee, user_id: user3.id, event_id: event.id)
    attendee4 = FactoryGirl.create(:attendee, user_id: user4.id, event_id: event.id)
    attendee5 = FactoryGirl.create(:attendee, user_id: user5.id, event_id: event.id)
    
    sign_in(user1)
    visit event_path(event)
    within(:css, "#connection.value2") do
      select attendee2.user.name, from: "pick[picked_user_id]"
      click_on "Create Pick"
    end
    sign_out(user1)

    sign_in(user2)
    visit event_path(event)
    within(:css, "#connection.value1") do
      select attendee1.user.name, from: "pick[picked_user_id]"
      click_on "Create Pick"
    end
    sign_out(user2)

    sign_in(user3)
    visit event_path(event)
    within(:css, "#connection.value3") do
      select attendee2.user.name, from: "pick[picked_user_id]"
      click_on "Create Pick"
    end
    sign_out(user3)

    sign_in(user4)
    visit event_path(event)
    within(:css, "#connection.value1") do
      select attendee2.user.name, from: "pick[picked_user_id]"
      click_on "Create Pick"
    end
    sign_out(user4)

    sign_in(user5)
    visit event_path(event)
    within(:css, "#connection.value1") do
      select attendee3.user.name, from: "pick[picked_user_id]"
      click_on "Create Pick"
    end
    sign_out(user5)

    expect(Pick.count).to eq 5

    sign_in(user)

    visit event_path(event)
    click_on "View Map"
    save_and_open_page
    expect(page).to have_content(attendee2.user.name)
  end
end
