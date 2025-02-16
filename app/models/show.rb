class Show < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :event_request, optional: true

  has_many :screenings, dependent: :destroy
  has_many :screens, through: :screenings
  has_many :bookings, through: :screenings, dependent: :destroy
  has_many :feedbacks, as: :commentable, dependent: :destroy

  after_update :show_cancelled, if: -> { status_previously_changed? && status == 'cancelled' }

  enum :category, { movie: 0, play: 1, sport: 2, event: 3 }
  enum :status, { inactive: 0, active: 1, pending: 2, cancelled: 3 }

  validates :name, :description, :cast, :languages, :genres, :category, :status, :duration,
            :release_date, presence: true
  validates :category, inclusion: { in: categories.keys }
  validates :duration,
            inclusion: { in: 30..1440,
                         message: 'enter a valid duration of minutes between 30(half hour) and 1440 minutes(24 hours)' }
  validate :languages_must_be_valid
  validate :genres_must_be_valid

  has_one_attached :poster, dependent: :destroy do |attachable|
    attachable.variant :display, resize_to_fit: [300, 350], preprocessed: true
  end

  validates :poster, attached: true,
                     content_type: { in: %w[image/jpeg image/jpg image/png], message: 'must be valid image format' },
                     size: { between: (1.kilobyte)..(5.megabytes), message: 'should be less than 5 MB' },
                     dimension: { width: { min: 200, max: 600 },
                                  height: { min: 200, max: 600 } }

  scope :active, -> { where(status: :active).includes(poster_attachment: :blob) }
  scope :can_book, -> { joins(:screenings).distinct }
  scope :active_forms, -> { where(status: :active) } # when using in forms avoid eager loading
  scope :available, -> { active_forms.where.missing(:event_request) }

  # home page
  scope :recommended, -> { order(created_at: :desc).active.can_book.take(5) }
  scope :by_language, lambda { |language|
                        where(':languages = ANY (languages)', languages: language).active.take(5)
                      }
  scope :except_movies, -> { where.not(category: :movie).active.can_book.take(5) }

  def self.languages
    { 'hindi' => 'hindi', 'english' => 'english', 'gujarati' => 'gujarati', 'tamil' => 'tamil', 'telugu' => 'telugu' }
  end

  def languages=(values)
    super(values.compact_blank)
  end

  def self.genres
    { 'action' => 'action', 'adventure' => 'adventure', 'animation' => 'animation', 'biography' => 'biography',
      'comedy' => 'comedy', 'crime' => 'crime', 'documentary' => 'documentary', 'drama' => 'drama', 'fantasy' => 'dantasy', 'historical' => 'historical', 'horror' => 'horror', 'mystery' => 'mystery', 'romance' => 'romance', 'science_fiction' => 'science fiction', 'unspecified' => 'unspecified' }
  end

  def genres=(values)
    super(values.compact_blank)
  end

  def average_rating
    feedbacks.average(:rating).to_f.round(1)
  end

  def languages_must_be_valid
    invalid_languages = languages - self.class.languages.keys
    errors.add(:languages, 'contains invalid languages') if invalid_languages.any?
  end

  def genres_must_be_valid
    invalid_genres = genres - self.class.genres.keys
    errors.add(:genres, 'contains invalid genres') if invalid_genres.any?
  end

  private

  def show_cancelled
    screenings.destroy_all
  end
end
