class Show < ApplicationRecord
  include Showable

  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :event_request, optional: true

  has_many :screenings, dependent: :destroy
  has_many :screens, through: :screenings
  has_many :bookings, through: :screenings, dependent: :destroy
  has_many :feedbacks, as: :commentable, dependent: :destroy

  after_update :show_cancelled, if: -> { status_previously_changed? && status == 'cancelled' }

  enum :status, { inactive: 0, active: 1, pending: 2, cancelled: 3 }

  scope :active, -> { where(status: :active).includes(:poster_attachment) }
  scope :available_screenings, -> { joins(:screenings).merge(Screening.available_show_timings).distinct }
  scope :can_book, -> { joins(:screenings).available_screenings.distinct }
  scope :active_forms, -> { where(status: :active) } # when using in forms avoid eager loading
  scope :available, -> { active_forms.where.missing(:event_request) }

  # home page
  scope :recommended, -> { order(created_at: :desc).active.can_book.take(5) }
  scope :by_language, lambda { |language|
                        where(':languages = ANY (languages)', languages: language).active.can_book.take(5)
                      }
  scope :except_movies, -> { where.not(category: :movie).active.can_book.take(5) }

  # views helper
  def available_screenings
    screenings.available_show_timings
  end

  def average_rating
    feedbacks.average(:rating).to_f.round(1)
  end

  private

  def show_cancelled
    screenings.destroy_all
  end
end
