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

  validates :name, :description, :cast, :poster, :language, :genre, :category, :status, :duration,
            :release_date, presence: true
  validates :name, uniqueness: true
  validates :language, inclusion: { in: languages.keys }
  validates :genre, inclusion: { in: genres.keys }
  validates :category, inclusion: { in: categories.keys }

  scope :recommended, -> { order(created_at: :desc).includes(poster_attachment: :blob).take(5) }

  scope :movies, -> { where(category: :movie).includes(poster_attachment: :blob) }
  scope :plays, -> { where(category: :play).includes(poster_attachment: :blob) }
  scope :sports, -> { where(category: :sport).includes(poster_attachment: :blob) }
  scope :events, -> { where(category: :event).includes(poster_attachment: :blob) }

  scope :gujarati, -> { where(language: :gujarati).includes(poster_attachment: :blob).take(5) }

  scope :action, -> { where(genre: :action).includes(poster_attachment: :blob).take(5) }

  scope :except_movies, -> { where.not(category: :movie).includes(poster_attachment: :blob) }

  def average_rating
    feedbacks.average(:rating).to_f.round(1)
  end
end
