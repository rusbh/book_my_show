class SearchController < ApplicationController
  def index
    q = params[:query]
    @shows = Show.ransack(name_cont: q).result(distinct: true).take(5)
    @theaters = Theater.ransack(name_cont: q).result(distinct: true).take(5)
  end
end
