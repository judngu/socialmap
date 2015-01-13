require "rails_helper"

describe "views a list of events" do 

  it "should show a page that lists events with links to the event" do

    FactoryGirl.create_list(:event, 20)

    visit events_path
    save_and_open_page

    expect(page).to have_content("All Events")
  end
end


