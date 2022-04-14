module Api
  module V1
    module Chapters
      class ChapterResource < Api::V1::BaseResource
        #default_within book: :

        attributes :id,
                   :title

         has_one :book, resource: Api::V1::Books::BookResource
      end
    end
  end
end