class EventRequest < ApplicationRecord
  after_update :handle_status_change, if: -> { status_previously_changed?(from: :pending) }
  before_create :release_date_before_end_date

  belongs_to :theater
  belongs_to :user

  has_one :show

  enum category: %i[movie play sport event]
  enum status: %i[pending approved rejected]

  validates :name, :description, :cast, :languages, :genres, :category, :status, :duration,
            :release_date, :end_date, :at_timeof, presence: true
  validates :category, inclusion: { in: categories.keys }
  validates :duration,
            inclusion: { in: 30..1440,
                         message: 'enter a valid duration of minutes between 30(half hour) and 1440 minutes(24 hours)' }
  validate :languages_must_be_valid
  validate :genres_must_be_valid

  has_one_attached :poster, dependent: :destroy do |attachable|
    attachable.variant :display, resize_to_fit: [300, 350], preprocessed: true
  end
  has_one_attached :permit, dependent: :destroy

  validates :poster, attached: true,
                     content_type: { in: %w[image/jpeg image/jpg image/png], message: 'must be valid image format' },
                     size: { between: 1.kilobyte..5.megabytes, message: 'should be less than 5 MB' },
                     dimension: { width: { min: 200, max: 600 },
                                  height: { min: 200, max: 600 } }

  validates :permit, attached: true,
                     content_type: { in: %w[application/pdf], message: 'must be valid pdf format' },
                     size: { between: 1.kilobyte..10.megabytes, message: 'should be less than 10 MB' }

  def self.languages
    { 'hindi' => 'hindi', 'english' => 'english', 'gujarati' => 'gujarati',
      'tamil' => 'tamil', 'telugu' => 'telugu' }
  end

  def languages=(values)
    super(values.reject(&:blank?))
  end

  def self.genres
    { 'action' => 'action', 'adventure' => 'adventure', 'animation' => 'animation', 'biography' => 'biography',
      'comedy' => 'comedy', 'crime' => 'crime', 'documentary' => 'documentary', 'drama' => 'drama', 'fantasy' => 'dantasy', 'historical' => 'historical', 'horror' => 'horror', 'mystery' => 'mystery', 'romance' => 'romance', 'science_fiction' => 'science fiction', 'unspecified' => 'unspecified' }
  end

  def genres=(values)
    super(values.reject(&:blank?))
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

  def handle_status_change
    if approved?
      activate_show_amd_inform_admins
      EventRequestMailer.event_request_approved(self).deliver_later
    elsif rejected?
      reject_show_request
    end
  end

  def activate_show_amd_inform_admins
    show = Show.find_by(name:)
    show&.update!(status: :active)
    EventRequestMailer.theater_event_request(self).deliver_later
  end

  def reject_show_request
    show = Show.find_by(name:)
    show&.destroy!
    EventRequestMailer.event_request_rejected(self).deliver_later
  end

  def release_date_before_end_date
    return unless release_date > end_date

    errors.add(:release_date, 'must be before the end date')
    throw(:abort)
  end
end
