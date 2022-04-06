class ChaptersController < ApplicationController
  before_action :set_book
  before_action :set_chapter, only: %i[show destroy]

  def index
    render json: Chapter.all
  end

  def show
    render json: @chapter
  end

  def new
    render json: @chapter = Chapter.new
  end

  # post
  def create
    render json: @book.chapters.create(data: params['data'], title: params['title'])
  end

  def destroy
    @chapter.delete
    render json: {Itog: "destroy it all!"}
  end

  def search
    render json: Chapter.search(params[:keyword])
  end

  private

  def set_chapter
    @chapter = @book.chapters.find(params[:id])
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

  def chapter_params
    params.require(:chapter).permit(:title, :data)
  end
end
