require 'ffaker'

library = Library.find_or_create_by!(name: FFaker::Address.city)

books_array = [
  [10_000, FFaker::Book.title, FFaker::Book.author],
  [20_000, FFaker::Book.title, FFaker::Book.author],
  [30_000, FFaker::Book.title, FFaker::Book.author],
  [40_000, FFaker::Book.title, FFaker::Book.author],
  [50_000, FFaker::Book.title, FFaker::Book.author]
].each do |price, title, author|
  Book.find_or_create_by!(price: price, name: title, author: author, library: library)
end

chapters_array = [
  [FFaker::Book.genre, FFaker::Book.description],
  [FFaker::Book.genre, FFaker::Book.description],
  [FFaker::Book.genre, FFaker::Book.description],
  [FFaker::Book.genre, FFaker::Book.description],
  [FFaker::Book.genre, FFaker::Book.description],
  [FFaker::Book.genre, FFaker::Book.description],
  [FFaker::Book.genre, FFaker::Book.description],
  [FFaker::Book.genre, FFaker::Book.description]
].each do |title, data|
  Chapter.find_or_create_by!(title: title, data: data, book: Book.all.sample)
end
