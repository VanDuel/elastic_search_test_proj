module Api
  module V1
    module Books
      class BookResource < Api::V1::BaseResource
        default_within :chapters

        attributes :id,
                   :name,
                   :price,
                   :author

        has_many :chapters, resource: Api::V1::Chapters::ChapterResource
      end
    end
  end
end