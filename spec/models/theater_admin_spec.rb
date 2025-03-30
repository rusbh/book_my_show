require "rails_helper"

RSpec.describe(TheaterAdmin, type: :model) do
  describe "validations" do
    xit { is_expected.to(validate_uniqueness_of(:user_id).scoped_to(:theater_id)) }
  end

  describe "associations" do
    it { is_expected.to(belong_to(:theater)) }
    it { is_expected.to(belong_to(:admin).class_name("User").with_foreign_key("user_id")) }
  end
end
