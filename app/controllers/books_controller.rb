class BooksController < ApplicationController
  before_action :set_library, except: :search
  before_action :set_book, only: %i[show destroy]

  def index
    render json: Book.all
  end

  def show
    render json: @book
  end

  def new
    render json: @book = Book.new
  end

  # post
  def create
    @book = @library.books.create(price: params['price'], name: params['name'], author: params['author'])
  end

  def destroy
    @book.delete
    render json: {Itog: "destroy it all!"}
  end

  def search
    render json: Book.search(params[:keyword])
  end

  private

  def set_book
    @book = @library.books.find(params[:id])
  end

  def set_library
    @library = Library.find(params[:library_id])
  end

  def book_params
    params.fetch(:book, {}).permit(:name, :author, :price)
  end
end
