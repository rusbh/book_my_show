class Admin::ShowsController < Admin::BaseController
  before_action :set_theater
  # before_action :set_show, only: %i[ show edit update destroy ]

  def index
    @shows = @theater.shows
  end

  # def show; end

  # def new
  #   @show = Show.new
  # end

  # def create
  #   @show = Show.new(show_params)

  #   respond_to do |format|
  #     if @show.save
  #       format.html do
  #         redirect_to admin_screen_url(@screen.theater, @screen), notice: 'Screen was successfully created.'
  #       end
  #       format.json { render :show, status: :created, location: @screen }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @screen.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def edit; end

  # def update
  #   respond_to do |format|
  #     if @show.update(screen_params)
  #       format.html do
  #         redirect_to admin_screen_url(@screen.theater, @screen), notice: 'Screen was successfully updated.'
  #       end
  #       format.json { render :show, status: :ok, location: @screen }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @screen.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def destroy
  #   @screen.destroy!

  #   respond_to do |format|
  #     format.html { redirect_to admin_root_url, notice: 'Screen was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private

  # getting admin's assigned theater
  def set_theater
    @theater_admin = TheaterAdmin.where(user: current_user).first
    @theater = @theater_admin.theater
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_show
    @show = Show.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def show_params
    params.require(:show).permit(:name, :description, :poster, :cast, :language, :genre, :category, :imdb_rating,
                                 :price, :status, :duration, :release_date)
  end
end
