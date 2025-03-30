require "rails_helper"

RSpec.describe(User, type: :model) do
  describe "validations" do
    it { is_expected.to(validate_presence_of(:name)) }
  end

  describe "associations" do
    it { is_expected.to(have_many(:theater_admins).dependent(:destroy)) }
    it { is_expected.to(have_many(:theaters).through(:theater_admins)) }
    it { is_expected.to(have_many(:bookings).dependent(:destroy)) }
    it { is_expected.to(have_many(:feedbacks).dependent(:destroy)) }
    it { is_expected.to(have_many(:event_requests).dependent(:destroy)) }
    it { is_expected.to(have_one_attached(:avatar)) }
  end
end
