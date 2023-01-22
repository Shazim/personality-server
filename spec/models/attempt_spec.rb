require 'rails_helper'

RSpec.describe Attempt, type: :model do
  context "associations" do
    it "should assert belongs_to associations" do
      should belong_to(:user)
    end
  end
end
