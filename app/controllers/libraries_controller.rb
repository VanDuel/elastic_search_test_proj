class LibrariesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_library, only: %i[ show destroy ]

  def index
    @libraries = Library.all
    render json: @libraries
  end

  def show
    render json: @library
  end

  def new
    render json: @library = Library.new
  end

  def create #post
    @library = Library.create(name: params['name'])
  end

  def destroy
    @library.delete
    # render "deleted"
  end

  private

  def set_library
    @library = Library.find(params[:id])
  end

  def library_params
    params.fetch(:library, {}).permit(:name)
    #params.require(:library).permit(:name)
  end
end
