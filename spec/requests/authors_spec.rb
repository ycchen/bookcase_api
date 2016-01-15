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
      # author = {"data": {"type":"authors", "attributes":{"name": "Jane Doe"}}}

      # curl -H "Content-Type:application/json; charset=utf-8" -d '{"data": {"type":"authors", "attributes":{"name": "Jane Doe"}}}' http://localhost:3000/authors
			author = {
				data: {
					type: "authors",
					attributes: {
						name: "John Doe"
					}
				}
			}
      
      post '/authors',
      params: author.to_json,
      headers: { 'Content-Type': 'application/json' }

      expect(response.status).to eq 201
      body = JSON.parse(response.body)
      # puts body.inspect
      author_name = body['data']['attributes']['name']
      expect(author_name) == 'John Doe'
    end
  end

  describe "PUT /authors/:id" do
  	it "updates the specified author" do
  		FactoryGirl.create :author, name: 'John Doe', id: 1

  		author={
  			data: {
  				type: "authors",
  				id: 1,
  				attributes:{
  					name: "Will Smith"
  				}
  			}
  		}

  		put '/authors/1',
  		params: author.to_json,
  		headers: {'Content-Type': 'application/json'}

			expect(response.status).to eq 200

			body = JSON.parse(response.body)
			# puts body.inspect
			author_name = body['data']['attributes']['name']
			expect(author_name) == 'Will Smith'

  	end
  end
  
  describe "DELETE /authors/:id" do
  	it "deltes the specified author" do
  		FactoryGirl.create :author, name: 'John Doe', id: 1

  		delete '/authors/1'

  		expect(response.status).to eq 204
  	end
  end
end
