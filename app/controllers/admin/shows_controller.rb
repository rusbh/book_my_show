class Admin::ShowsController < Admin::BaseController
  before_action :set_theater
  before_action :set_screen
  before_action :set_show, only: %i[show edit update destroy]

  def index
    @shows = @screen.shows
  end

  def show; end

  def new
    @show = Show.new
    @show.screen_shows.build
  end

  def create
    @show = Show.new(show_params)

    respond_to do |format|
      if @show.save
        format.html { redirect_to admin_screen_show_url(@theater, @screen, @show), notice: 'Show was successfully created.' }
        format.json { render :show, status: :created, location: @show }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @show.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @show.update(show_params)
        format.html { redirect_to admin_screen_show_url(@theater, @screen, @show), notice: 'Show was successfully updated.' }
        format.json { render :show, status: :ok, location: @show }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @show.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @show.destroy!
    respond_to do |format|
      format.html { redirect_to admin_screen_shows_url(@theater, @screen), notice: 'Show was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # getting admin's assigned theater
  def set_theater
    @theater_admin = TheaterAdmin.where(user: current_user).first
    @theater = @theater_admin.theater
  end

  def set_screen
    @screen = Screen.find(params[:screen_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_show
    @show = Show.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def show_params
    params.require(:show).permit(:name, :description, :poster, :cast, :language, :genre, :category, :imdb_rating,
                                 :price, :status, :duration, :release_date, screen_shows_attributes: [:screen_id, :show_id, :start_date, :end_date])
  end
end
