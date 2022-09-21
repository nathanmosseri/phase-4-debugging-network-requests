class MoviesController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_nonprocessable_entity
  
  def index
    movies = Movie.all
    render json: movies
  end

  def create 
    movie = Movie.create(movie_params)
    render json: movie, status: :created 
  end

  private 

  def movie_params
    params.permit(:title, :year, :length, :director, :description, :poster_url, :category, :discount, :female_director)
  end

  def find_movie
    Movie.find(params[:id])
  end

  def render_not_found
    render json: {error: 'Movie not found'}, status: :not_found
  end

  def render_nonprocessable_entity(invalid)
    render json: {errors: invalid.record.errors}, status: :nonprocessable_entity
  end

end
