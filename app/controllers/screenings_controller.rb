class ScreeningsController < ApplicationController
  before_action :set_show

  def index
    @show_screenings = @show.screenings.includes(screen: [theater: :city])
  end

  private

  def set_show
    @show = Show.friendly.find(params[:show_id])
  end
end