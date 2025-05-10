class PaginationComponent < ApplicationComponent
  include Pagy::Frontend
  attr_reader :pagy

  def initialize(pagy:)
    @pagy = pagy
  end

  def render?
    pagy.pages > 1
  end
end
