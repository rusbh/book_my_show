require "rails_helper"

RSpec.describe(Feedback, type: :model) do
  describe "validations" do
    it { is_expected.to(validate_presence_of(:comment)) }
    it { is_expected.to(validate_presence_of(:rating)) }
    it { is_expected.to(validate_inclusion_of(:rating).in_array([1..10])) }
  end

  describe "associations" do
    it { is_expected.to(belong_to(:user)) }
    it { is_expected.to(belong_to(:feedbackable)) }
  end
end
