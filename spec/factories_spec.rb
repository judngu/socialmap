require "rails_helper"

RSpec.describe "Factories" do
  FactoryGirl.factories.map(&:name).each do |factory|
    it "The #{factory} is valid" do
      expect(FactoryGirl.build(factory)).to be_valid
    end
  end
end
