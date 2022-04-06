class Chapter < ApplicationRecord
  include Searchable

  belongs_to :book
end
