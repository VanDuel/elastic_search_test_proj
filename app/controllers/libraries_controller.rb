class LibrariesController < ApplicationController
  before_action :set_library, only: %i[show destroy]

  def index
    render json: Library.all
  end

  def show
    render json: @library
  end

  def new
    render json: @library = Library.new
  end

  # post
  def create
    render json: @library = Library.create(name: params['name'])
  end

  def destroy
    @library.delete
    # render "deleted"
  end

  def search
    render json: Library.search(params[:keyword])
  end

  private

  def set_library
    @library = Library.find(params[:id])
  end

  def library_params
    params.fetch(:library, {}).permit(:name)
  end
end
