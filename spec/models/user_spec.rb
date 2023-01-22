require 'rails_helper'

RSpec.describe User, type: :model do
  context "valid factory" do
    it "has a valid factory" do
      expect(build(:user)).to be_valid
    end
  end

  context "validations" do
    before { create(:user) }

    context "presence" do
      it { should validate_presence_of :email }
    end

    context "uniqueness" do
      it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    end
  end
end