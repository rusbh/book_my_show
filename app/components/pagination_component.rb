class PaginationComponent < ApplicationComponent
  include Pagy::Frontend
  attr_reader :pagy

  def initialize(pagy:)
    @pagy = pagy
  end
end
