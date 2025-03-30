require "rails_helper"

RSpec.describe(Booking, type: :model) do
  describe "validations" do
    it { is_expected.to(validate_presence_of(:ticket)) }
    it { is_expected.to(validate_presence_of(:booking_date)) }
    it { is_expected.to(validate_presence_of(:total_price)) }
  end

  describe "associations" do
    it { is_expected.to(belong_to(:user)) }
    it { is_expected.to(belong_to(:screening)) }
    it { is_expected.to(belong_to(:show_time)) }
  end
end
