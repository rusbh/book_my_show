class FlashComponent < ApplicationComponent
  attr_reader :flash

  def initialize(flash:)
    @flash = flash
  end

  def render?
    !!flash.any?
  end
end
