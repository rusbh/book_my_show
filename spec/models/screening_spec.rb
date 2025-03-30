require "rails_helper"

RSpec.describe(Screening, type: :model) do
  describe "validations" do
    xit { is_expected.to(validate_presence_of(:language)) }
    xit { is_expected.to(validate_presence_of(:price)) }
    xit { is_expected.to(validate_numericality_of(:price).is_greater_than(0)) }
    xit { is_expected.to(validate_presence_of(:start_date)) }
    xit { is_expected.to(validate_presence_of(:end_date)) }
  end

  describe "associations" do
    xit { is_expected.to(belong_to(:screen)) }
    xit { is_expected.to(belong_to(:show)) }
    it { is_expected.to(have_many(:bookings).dependent(:destroy)) }
    it { is_expected.to(have_many(:show_times).dependent(:destroy)) }
  end
end
