require "rails_helper"

RSpec.describe(Show, type: :model) do
  describe "validations" do
    it { is_expected.to(validate_presence_of(:name)) }
    it { is_expected.to(validate_presence_of(:description)) }
    it { is_expected.to(validate_presence_of(:cast)) }
    it { is_expected.to(validate_presence_of(:duration)) }
    it { is_expected.to(validate_presence_of(:release_date)) }
  end

  describe "associations" do
    it { is_expected.to(belong_to(:event_request).optional) }
    it { is_expected.to(have_many(:screenings).dependent(:destroy)) }
    it { is_expected.to(have_many(:screens).through(:screenings)) }
    it { is_expected.to(have_many(:bookings).through(:screenings).dependent(:destroy)) }
    it { is_expected.to(have_many(:feedbacks).dependent(:destroy)) }
    it { is_expected.to(have_one_attached(:poster)) }
  end
end
