class Show < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :screenings, dependent: :destroy
  has_many :screens, through: :screenings
  has_many :bookings, through: :screenings, dependent: :destroy

  has_many :feedbacks, as: :commentable, dependent: :destroy

  after_update :show_cancelled

  enum language: %i[hindi english gujarati tamil telugu]
  enum genre: %i[action adventure animation comedy crime documentary drama fantasy historical horror romance
                 science_fiction unspecified]
  enum category: %i[movie play sport event]
  enum status: %i[active cancelled]

  validates :name, :description, :cast, :language, :genre, :category, :status, :duration,
            :release_date, presence: true
  validates :language, inclusion: { in: languages.keys }
  validates :genre, inclusion: { in: genres.keys }
  validates :category, inclusion: { in: categories.keys }
  validates :duration,
            inclusion: { in: 30..1440,
                         message: 'enter a valid duration of minutes between 30(half hour) and 1440 minutes(24 hours)' }

  has_one_attached :poster, dependent: :destroy do |attachable|
    attachable.variant :display, resize_to_limit: [300, 350]
  end

  validates :poster, attached: true,
                     content_type: { in: %w[image/jpeg image/jpg image/png], message: 'must be valid image format' },
                     size: { between: 1.kilobyte..5.megabytes, message: 'should be less than 5 MB' },
                     dimension: { width: { min: 200, max: 600 },
                                  height: { min: 200, max: 600 } }

  scope :active, -> { where(status: :active).includes(poster_attachment: :blob) }
  scope :can_book, -> { joins(:screenings).distinct }

  # home page
  scope :recommended, -> { order(created_at: :desc).active.can_book.take(5) }
  scope :action, -> { where(genre: :action).active.can_book.take(5) }
  scope :gujarati, -> { where(language: :gujarati).active.can_book.take(5) }
  scope :except_movies, -> { where.not(category: :movie).active.can_book.take(5) }

  scope :active_form, -> { where(status: :active) } # for forms

  def average_rating
    feedbacks.average(:rating).to_f.round(1)
  end

  private

  def show_cancelled
    return unless status_previously_changed? && status == 'cancelled'

    screenings.destroy_all
  end
end
