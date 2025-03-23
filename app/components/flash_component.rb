class FlashComponent < ApplicationComponent
  attr_reader :type, :message

  def initialize(type:, message:)
    @type = type
    @message = message
  end

  def render?
    !!flash.any?
  end

  private

  def color_classes
    case type
    when "alert"
      "bg-red-50 border-red-500/50 text-gray-800"
    when "success"
      "bg-green-50 border-green-500/50 text-gray-800"
    when "error"
      "bg-red-50 border-red-500/50 text-gray-800"
    when "warning"
      "bg-yellow-50 border-yellow-500/50 text-gray-800"
    else # notice, etc...
      "bg-white border-gray-300/90 text-gray-800"
    end
  end
end
