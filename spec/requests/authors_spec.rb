require 'rails_helper'

RSpec.describe "Authors", :type => :request do

  describe "GET /authors" do
    it "returns all the authors" do
    	list_names = ['Jimmy Johnson', 'Janes Johnson']
    	list_names.each do |full_name|
    		FactoryGirl.create :author, name: full_name
    	end

    	get '/authors'

    	expect(response.status).to eq 200

    	body = JSON.parse(response.body)
    	puts body.inspect
    	author_names = body['data'].map{|author| author['attributes']['name']}
    	# puts author_names.inspect
    	expect(author_names).to match_array(list_names)
    end
  end

  describe "GET /authors/:id" do
    it "returns the specified author" do
    	FactoryGirl.create :author, name: 'John Doe'

    	get '/authors/1'

    	body = JSON.parse(response.body)
			puts body.inspect
			author_name = body['data']['attributes']['name']
			expect(author_name) == 'John Doe'

    end
  end

  describe "POST /authors" do
  	it "creates the specified author" do
      author = {
        data: {
          type: "authors",
          attributes: {
            name: "John Doe"
          }
        }
      }
     # author={
					#   "data":{
					#     "type": "authors",
					#     "attributes": {
					#       "name": "John Doe"
					#     }
					# 	}
					# }

      puts author.to_json

      post '/authors',
      			params: author.to_json,
      			headers: { 'Content-Type': 'application/vnd.api+json' }

      # expect(response.status).to eq 201
      # body = JSON.parse(response.body)

      # author_name = body['data']['attributes']['name']
      # expect(author_name) == 'John Doe'
    end
  end

  describe "PUT /authors/:id" do
  	it "updates the specified author" do

  	end
  end
  
  describe "DELETE /authors/:id" do
  	it "deltes the specified author" do

  	end
  end
end
