class TheatersController < ApplicationController
  before_action :set_theater, only: %i[show]

  # GET /theaters or /theaters.json
  def index
    @theaters = Theater.all
  end

  # GET /theaters/1 or /theaters/1.json
  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_theater
    @theater = Theater.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def theater_params
    params.require(:theater).permit(:name, :address, :city_id)
  end
end
