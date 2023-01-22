require 'rails_helper'

RSpec.describe Question, type: :model do
  context "validations" do
    it "should validate presence of title" do
      should validate_presence_of(:question_text)
    end
  end

  context "associations" do
    it "should assert has_many associations" do
      should have_many(:answers)
    end
  end
end
