class Screening < ApplicationRecord
  belongs_to :screen
  belongs_to :show

  has_many :bookings, dependent: :destroy
  has_many :show_times, dependent: :destroy

  audited associated_with: :screen

  before_create :start_date_before_end_date
  after_destroy :update_screen_status
  after_save :update_screen_status

  validates :language, :price, :start_date, :end_date, presence: true
  validates :price, numericality: { greater_than: 0 }

  validate :no_overlapping_screenings
  validate :prohibit_screening_by_screen_status

  accepts_nested_attributes_for :show_times,
                                reject_if: :all_blank,
                                allow_destroy: true

  scope :available_show_times, lambda {
    joins(:show_times).where("show_times.at_timeof > ?", 1.hour.ago).distinct
  }

  private

  def start_date_before_end_date
    return if start_date <= end_date

    errors.add(:start_date, "must be before the end date")
    throw(:abort)
  end

  def no_overlapping_screenings
    overlapping_screenings = Screening.where(screen_id:)
      .where.not(id:)
      .where("start_date < ? AND end_date > ?", end_date, start_date)

    return unless overlapping_screenings.exists?

    errors.add(
      :base,
      "This screen is already assigned for the selected date range",
    )
  end

  def prohibit_screening_by_screen_status
    return unless screen.in_maintenance? || screen.unavailable?

    errors.add(
      :base,
      "Screen is in maintenance or unavailable for new screenings",
    )
  end

  def update_screen_status
    if screen.screenings.exists?([
      "start_date <= :current_time AND end_date >= :current_time", { current_time: Time.current },
    ])
      screen.update(status: :running)
    else
      screen.update(status: :idle)
    end
  end
end
