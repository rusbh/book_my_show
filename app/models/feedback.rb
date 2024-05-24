class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  enum type_of: %i[review feedback]

  scope :is_review, -> { where(type_of: :review) }
  scope :is_feedback, -> { where(type_of: :feedback) }

  validates :comment, :type_of, presence: true
end
