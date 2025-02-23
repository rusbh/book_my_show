class EventRequest < ApplicationRecord
  include Showable

  before_create :release_date_before_end_date
  after_update :handle_status_change, if: -> { status_previously_changed?(from: :pending) }

  belongs_to :theater
  belongs_to :user

  has_one :show, dependent: :nullify

  enum :status, { pending: 0, approved: 1, rejected: 2 }

  has_one_attached :permit, dependent: :destroy

  validates :permit, attached: true,
                     content_type: { in: %w[application/pdf], message: 'must be valid pdf format' },
                     size: { between: (1.kilobyte)..(10.megabytes), message: 'should be less than 10 MB' }

  private

  def handle_status_change
    if approved?
      activate_show_amd_inform_admins
      EventRequestMailer.event_request_approved(self).deliver_later
    elsif rejected?
      reject_show_request
    end
  end

  def activate_show_amd_inform_admins
    show = Show.find_by(name:)
    show&.update!(status: :active)
    EventRequestMailer.theater_event_request(self).deliver_later
  end

  def reject_show_request
    show = Show.find_by(name:)
    show&.destroy!
    EventRequestMailer.event_request_rejected(self).deliver_later
  end

  def release_date_before_end_date
    return unless release_date > end_date

    errors.add(:release_date, 'must be before the end date')
    throw(:abort)
  end
end
