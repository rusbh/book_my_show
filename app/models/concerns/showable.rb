# frozen_string_literal: true

module Showable
  extend ActiveSupport::Concern

  included do
    enum :category, { movie: 0, play: 1, sport: 2, event: 3 }

    validates :name, :description, :cast, :languages, :genres, :category, :duration,
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
                       content_type: { in: %w[image/jpeg image/png], message: 'must be valid image format' },
                       size: { between: (1.kilobyte)..(5.megabytes), message: 'should be less than 5 MB' },
                       dimension: { width: { min: 200, max: 600 },
                                    height: { min: 200, max: 600 } }
  end

  class_methods do
    def languages
      %w[hindi english gujarati tamil telugu].index_by(&:itself).freeze
    end

    def genres
      %w[action adventure animation biography comedy crime documentary drama fantasy historical horror mystery romance science_fiction unspecified]
        .index_by(&:itself).freeze
    end
  end

  def languages=(values)
    super(values.compact_blank)
  end

  def genres=(values)
    super(values.compact_blank)
  end

  private

  def languages_must_be_valid
    invalid_languages = languages - self.class.languages.keys
    errors.add(:languages, 'contains invalid languages') if invalid_languages.any?
  end

  def genres_must_be_valid
    invalid_genres = genres - self.class.genres.keys
    errors.add(:genres, 'contains invalid genres') if invalid_genres.any?
  end
end
