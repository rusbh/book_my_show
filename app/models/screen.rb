class Screen < ApplicationRecord
  belongs_to :theater
  
  has_many :screenings, dependent: :destroy
  has_many :shows, through: :screenings

  before_update :discard_screenings_if_maintenance_or_unavailable
  
  enum status: %i[idle running in_maintenance unavailable]
  
  validates_presence_of :screen_no, message: "/ name can't be blank"

  private

  def discard_screenings_if_maintenance_or_unavailable
    if status_changed? && (in_maintenance?)
      screenings.destroy_all
      self.status = :in_maintenance
    elsif status_changed? && (unavailable?)
      screenings.destroy_all
      self.status = :unavailable 
    end
  end
end
