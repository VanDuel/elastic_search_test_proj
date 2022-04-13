class Api::V1::FairyTalesController < Api::V1::BaseController
  before_action :set_library, except: :search
  before_action :set_book, only: %i[show destroy]

  def index
    serialized_response(
      serializers: {
        data: ::Api::V1::Books::BooksResource.new(Book.all)
      }
    )
    #render json: Book.all
  end

  def show
    serialized_response(serializers: { data: ::Api::V1::Books::BookResource.new(@book) })
    #render json: @book
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
    @book = Book.find(params[:id])
  end

  def set_library
    @library = Library.find(params[:library_id])
  end

  def book_params
    params.fetch(:book, {}).permit(:name, :author, :price)
  end
end
