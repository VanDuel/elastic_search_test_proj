class Book < ApplicationRecord
  include Searchable

  belongs_to  :library
  has_many    :chapters
end
