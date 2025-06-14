class Screen < ApplicationRecord
  belongs_to :theater

  has_many :screenings, dependent: :destroy
  has_many :shows, through: :screenings

  audited associated_with: :theater
  has_associated_audits

  after_update_commit :discard_screenings_if_maintenance_or_unavailable, if: -> {
    status_previously_changed?
  }

  enum :status, idle: 0, running: 1, in_maintenance: 2, unavailable: 3

  validates :screen_name, :seats, presence: true
  validates :screen_name,
            format: {
              with: /\A([A-Za-z]+|[1-9]\d*)\z/,
              message: "/ no. is invalid",
            }
  validates :seats, numericality: { greater_than_or_equal_to: 0 }

  private

  def discard_screenings_if_maintenance_or_unavailable
    if in_maintenance?
      screenings.destroy_all
      self.status = :in_maintenance
    elsif unavailable?
      screenings.destroy_all
      self.status = :unavailable
    end
  end
end
