class Show < ApplicationRecord
  has_one_attached :poster, dependent: :destroy do |attachable|
    attachable.variant :display, resize_to_limit: [300, 400]
  end

  has_many :screen_shows, dependent: :destroy
  has_many :screens, through: :screen_shows

  has_many :bookings, dependent: :destroy
  has_many :feedbacks, -> { is_feedback }, as: :commentable
  has_many :reviews, -> { is_review }, class_name: 'Feedback', as: :commentable

  enum language: %i[hindi english gujarati tamil telugu]
	enum genre: %i[action adventure animation comedy crime documentary drama fantasy historical horror romance science_fiction unspecified]
  enum category: %i[movie play sport event]
	enum status: %i[idle running cancelled]

  validates :name, :description, :cast, :language, :genre, :category, :imdb_rating, :status, :duration, :release_date, presence: true
  validates :language, inclusion: { in: languages.keys }
  validates :genre, inclusion: { in: genres.keys }
  validates :category, inclusion: { in: categories.keys }
  validates :imdb_rating, inclusion: { in: 1..10 }

  accepts_nested_attributes_for :screen_shows, reject_if: :all_blank, allow_destroy: true
end
