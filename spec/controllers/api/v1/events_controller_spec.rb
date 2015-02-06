require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do
  describe "GET #index" do
    it "returns all the events, ordered by recency" do
      older_event = FactoryGirl.create(:event,
        created_at: Time.zone.now - 1.week)
      old_event = FactoryGirl.create(:event,
        created_at: Time.zone.now - 1.day)
      oldest_event = FactoryGirl.create(:event,
        created_at: Time.zone.now - 1.year)

      ordered_events = [old_event, older_event, oldest_event]

      get :index

      serialized_events = ActiveModel::ArraySerializer.new(ordered_events,
        root: :events)
      json = JSON.parse(response.body)


      expect(response.status).to eq 200
      expect(json).to be_json_eq(serialized_events)
    end
  end
end
