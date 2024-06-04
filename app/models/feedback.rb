class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :comment, presence: true
end
