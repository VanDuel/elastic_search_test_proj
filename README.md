# ElasticSearch Rails application demo

To run this app locally, you have to have installed:
* ruby 3.0 + rails
* elasticsearch (install and run it on default port :9200)

To make your search so `elastic` you shoud run in `rails c`:
```
Model.__elasticsearch__.create_index!
Model.import
```
Then you may normally start Rails server through `rails s` and sent `GET` with `keyword` param to any of
```
/librarysearch
/booksearch
/chaptersearch
```
to find `Library`, `Book` or `Chapter`.

