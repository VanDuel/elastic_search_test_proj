class ChaptersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_book

  def index
    @chapters = @book.chapters.all
    render json: @chapters
  end

  def show
    render json: @chapter = @book.chapters.find(params[:id])
  end

  def new
    render json: @chapter = Chapter.new
  end

  def create #post
    render json: @chapter = @book.chapters.create(data: params['data'], title: params['title'])
  end

  def destroy
    @chapter.delete
    render json: {Itog: "destroy it all!"}
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end


  def book_params
    params.require(:chapter).permit(:title, :data)
  end
end
