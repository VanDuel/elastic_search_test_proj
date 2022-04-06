class Library < ApplicationRecord
  include Searchable

  has_many :books
end
