class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :comment, :rating, presence: true

  validates :rating, inclusion: { in: 1..10 }
end
