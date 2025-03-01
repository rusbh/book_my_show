class ScreeningsController < ApplicationController
  before_action :set_show

  def index
    @show_screenings = @show.screenings.includes(screen: :theater).select do |screening|
      last_show_time = screening.show_times.last
      last_show_time&.seats&.positive?
    end

    @last_show_times = @show_screenings.map do |screening|
      screening.show_times.last&.at_timeof
    end
  end

  private

  def set_show
    @show = Show.friendly.find(params[:show_id])
  end
end
