require "rails_helper"

RSpec.describe(EventRequest, type: :model) do
  describe "validations" do
    it { is_expected.to(validate_presence_of(:name)) }
    it { is_expected.to(validate_presence_of(:description)) }
    it { is_expected.to(validate_presence_of(:cast)) }
    it { is_expected.to(validate_presence_of(:duration)) }
    it { is_expected.to(validate_presence_of(:release_date)) }
  end

  describe "associations" do
    it { is_expected.to(belong_to(:theater)) }
    it { is_expected.to(have_one(:show).dependent(:nullify)) }
    it { is_expected.to(have_one_attached(:permit)) }
  end
end
