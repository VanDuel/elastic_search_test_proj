module Api
  module V1
    module Books
      class BooksResource < Api::V1::EnumerableResource
        collection_resource(BookResource)
      end
    end
  end
end
