class BooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_lib

  def index
    @books = @library.books.all
    render json: @books
  end

  def show
    render json: @book = @library.books.find(params [:id])
  end

  def new
    render json: @book = Book.new
  end

  def create #post
    @book = @library.books.create(price: params['price'], name: params['name'], author: params['author'])
  end

  def destroy
    @book.delete
    render json: {Itog: "destroy it all!"}
  end

  private

  def set_lib
    @library = Library.find(params[:library_id])
  end


  def book_params
    params.require(:book).permit(:name, :author, :price)
  end
end
