class Show < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_one_attached :poster, dependent: :destroy do |attachable|
    attachable.variant :display, resize_to_limit: [300, 350]
  end

  has_many :screenings, dependent: :destroy
  has_many :screens, through: :screenings

  has_many :feedbacks, as: :commentable, dependent: :destroy

  enum language: %i[hindi english gujarati tamil telugu]
  enum genre: %i[action adventure animation comedy crime documentary drama fantasy historical horror romance
                 science_fiction unspecified]
  enum category: %i[movie play sport event]
  enum status: %i[idle running cancelled]

  validates :name, :description, :cast, :language, :genre, :category, :imdb_rating, :status, :duration, :release_date,
            presence: true
  validates :name, uniqueness: true
  validates :language, inclusion: { in: languages.keys }
  validates :genre, inclusion: { in: genres.keys }
  validates :category, inclusion: { in: categories.keys }
  validates :imdb_rating, inclusion: { in: 1..10 }

  scope :recommened, -> { order(created_at: :desc).take(5) }

  scope :hindi_shows, -> { where(language: :hindi).take(5) }
  scope :events, -> { where(category: :event).take(5) }
  scope :plays, -> { where(category: :play).take(5) }
  scope :sport, -> { where(language: :hindi).take(5) }
end
