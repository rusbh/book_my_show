require "rails_helper"

RSpec.describe(Theater, type: :model) do
  describe "validations" do
    it { is_expected.to(validate_presence_of(:name)) }
    it { is_expected.to(validate_uniqueness_of(:name)) }
    it { is_expected.to(validate_presence_of(:address)) }
    it { is_expected.to(validate_presence_of(:pincode)) }
    it { is_expected.to(validate_numericality_of(:pincode).only_integer) }
  end

  describe "associations" do
    it { is_expected.to(have_many(:screens).dependent(:destroy)) }
    it { is_expected.to(have_many(:shows).through(:screens)) }
    it { is_expected.to(have_many(:feedbacks).dependent(:destroy)) }
    it { is_expected.to(have_many(:theater_admins).dependent(:destroy)) }
    it { is_expected.to(have_many(:admins).through(:theater_admins)) }
    it { is_expected.to(have_many(:event_requests).dependent(:destroy)) }
  end
end
