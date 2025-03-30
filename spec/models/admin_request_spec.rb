require "rails_helper"

RSpec.describe(AdminRequest, type: :model) do
  describe "validations" do
    it { is_expected.to(validate_presence_of(:contact_email)) }
    it { is_expected.to(validate_presence_of(:contact_no)) }
    it { is_expected.to(validate_presence_of(:admin_emails)) }
    it { is_expected.to(validate_presence_of(:theater_name)) }
    it { is_expected.to(validate_presence_of(:theater_address)) }
    it { is_expected.to(validate_presence_of(:pincode)) }
    it { is_expected.to(validate_presence_of(:business_license)) }
    it { is_expected.to(validate_presence_of(:ownership_proof)) }
    it { is_expected.to(validate_presence_of(:insurance)) }
    it { is_expected.to(validate_presence_of(:status)) }
  end

  describe "associations" do
    it { is_expected.to(have_one_attached(:business_license)) }
    it { is_expected.to(have_one_attached(:ownership_proof)) }
    it { is_expected.to(have_one_attached(:noc)) }
    it { is_expected.to(have_one_attached(:insurance)) }
  end
end
