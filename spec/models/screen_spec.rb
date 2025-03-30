require "rails_helper"

RSpec.describe(Screen, type: :model) do
  describe "validations" do
    it { is_expected.to(validate_presence_of(:screen_name)) }
    it { is_expected.to(validate_presence_of(:seats)) }

    it {
      expect(subject).to(validate_numericality_of(:seats).is_greater_than_or_equal_to(0))
    }
  end

  describe "associations" do
    it { is_expected.to(belong_to(:theater)) }
    it { is_expected.to(have_many(:screenings).dependent(:destroy)) }
    it { is_expected.to(have_many(:shows).through(:screenings)) }
  end
end
