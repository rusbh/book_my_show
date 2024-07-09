class AdminRequest < ApplicationRecord
  validates :contact_email, :contact_no, :admin_emails, :theater_name, :theater_address, :pincode, :business_license,
            :ownership_proof, :noc, :insurance, :status, presence: true
  validates :contact_email, uniqueness: { message: 'was already used once to fill this form.' },
                            format: { with: /\A[-a-z0-9_+.]+@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i, message: 'is in invalid format' }
  validates :admin_emails,
            format: {
              with: /\A[-a-z0-9_+.]+@([-a-z0-9]+\.)+[a-z0-9]{2,4}(\s*,\s*[-a-z0-9_+.]+@([-a-z0-9]+\.)+[a-z0-9]{2,4})*\z/i, message: 'must be in valid format with comma between them'
            }
  validates :theater_address, length: { in: 1..240, message: 'must be between 1 to 240 words' }
  validates :contact_no, uniqueness: true, length: { is: 10 }
  validates :pincode, length: { is: 6 }

  enum status: %i[pending approved rejected]

  has_one_attached :business_license
  has_one_attached :ownership_proof
  has_one_attached :noc
  has_one_attached :insurance

  validates :business_license, attached: true,
                               content_type: { in: %w[application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document], message: 'must be in valid format of .pdf, .docx, .doc' },
                               size: { between: 1.kilobyte..5.megabytes, message: 'should be less than 5 MB' }
  validates :ownership_proof, attached: true,
                              content_type: { in: %w[application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document], message: 'must be in valid format of .pdf, .docx, .doc' },
                              size: { between: 1.kilobyte..5.megabytes, message: 'should be less than 5 MB' }
  validates :noc, attached: true,
                  content_type: { in: %w[application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document], message: 'must be in valid format of .pdf, .docx, .doc' },
                  size: { between: 1.kilobyte..5.megabytes, message: 'should be less than 5 MB' }
  validates :insurance, attached: true,
                        content_type: { in: %w[application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document], message: 'must be in valid format of .pdf, .docx, .doc' },
                        size: { between: 1.kilobyte..5.megabytes, message: 'should be less than 5 MB' }

  validate :theater_name_already_exists
  validate :theater_address_already_exists
  validate :admin_emails_already_exists

  private

  def theater_name_already_exists
    return unless Theater.find_by(name: theater_name).present?

    errors.add(:theater_name, 'with this name already exists')
    throw(:abort)
  end

  def theater_address_already_exists
    return unless Theater.find_by(name: theater_address).present?

    errors.add(:theater_address, 'with this name already exists')
    throw(:abort)
  end

  def admin_emails_already_exists
    admin_emails.split(',').map(&:strip).each do |email|
      errors.add(:admin_emails, "#{email} is already a registered user") if User.find_by(email:).present?
    end
    throw(:abort)
  end
end
