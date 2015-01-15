FactoryGirl.define do 

  factory :user do
    sequence(:email) { |n| "email#{n}@gmail.com"}
    password "password"
    password_confirmation "password"
    sequence(:name) { |n| "Judy#{n}"}
  end
  
  factory :event do
    sequence(:name) { |n| "#{n} My Awesome Event" }
    address "123 Space St."
    location "Space"
    city "Rocketville"
    state "MA"
    question "Who do you think is best at this meeting?"
    sequence(:passphrase) { |n| "#{n} pass" }
    description "This event weeds out people who are underpreforming"
    user
  end

  factory :attendee do
    user
    event
  end

  factory :pick do
    user
    value "3"
    after(:build) do |pick|
      event = FactoryGirl.create(:event)
      picked = FactoryGirl.create(:attendee, event_id: event.id)
      pick.picked_user = picked.user
      pick.event = event
    end
  end
end
