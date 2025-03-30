require "rails_helper"

RSpec.describe(ShowTime, type: :model) do
  describe "validations" do
    it { is_expected.to(validate_presence_of(:at_timeof)) }
    it { is_expected.to(validate_presence_of(:seats)) }
    it { is_expected.to(validate_numericality_of(:seats).is_greater_than_or_equal_to(0)) }
  end

  describe "associations" do
    it { is_expected.to(belong_to(:screening)) }
    it { is_expected.to(have_many(:bookings).dependent(:destroy)) }
  end
end
