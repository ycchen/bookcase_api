## README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## create initial Rails 5 api application

rails new bookcase_api --api

## add rspec-rails and generate rspec file

rails g rspec:install

## add shoulda-matchers, factory_girl_rails and active_model_serializers gems in Gemfile

gem 'shoulda-matchers'

* configure shoulda-matchers in rails_helper.rb file

gem 'factory_girl_rails'

* create spec/factories folder and authors factory

gem 'active_model_serializers'

* create config/ams_json_serializer.rb to set Mime::Type and default json format

ActiveModel::Serializer.config.adapter = ActiveModel::Serializer::Adapter::JsonApi

* generate author serializer

rails g serializer <model name> <modle field 1> <modle field 2>

rails g serializer author id name created_at

## generate author model

rails g scaffold author name

## create spec/request/authors_spec.rb

* for POST and PUT the Content-Type needs to be application/json, for some reason the application/vnd.api+json will throw an error the params[:data] is empty.

## generate publisher model

rails g scaffold publisher name

## generate publication model

rails g model Publication book:references author:references

## generate book model

rails g scaffold book title isbn cover publisher:references

* generate Factory_Girl for book model

* genrate book model rspec



