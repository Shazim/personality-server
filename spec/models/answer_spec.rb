require 'rails_helper'

RSpec.describe Answer, type: :model do
  context "validations" do
    it "should validate presence of title" do
      should validate_presence_of(:answer_text)
      should validate_presence_of(:point)
    end
  end

  context "associations" do
    it "should assert belongs_to associations" do
      should belong_to(:question)
    end
  end
end
