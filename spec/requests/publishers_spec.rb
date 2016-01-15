require 'rails_helper'

RSpec.describe "Publishers", :type => :request do
  describe "GET /publishers" do
    it "returns all the publisers" do
    	list_publishers= ['Maning','Pragmatic Bookshelf']
    	
    	list_publishers.each do |publisher|
      	FactoryGirl.create :publisher, name: publisher
    	end

      get publishers_path

      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)
      # puts body.inspect
      publisher_names = body['data'].map{|publisher| publisher['attributes']['name']}
      # puts publisher_names.inspect
      expect(publisher_names).to match_array(list_publishers)
    end
  end

  describe "GET /publishers/:id" do
  	it "returns the specific publisher" do
  		FactoryGirl.create :publisher, name: 'Amazon'

  		get '/publishers/1'

  		body = JSON.parse(response.body)
  		publisher_name = body['data']['attributes']['name']
  		expect(publisher_name) == 'Amazon' 
  	end
  end

	describe "POST /publishers" do
  	it "creates the specific publisher" do
  		publisher ={
  			data:{
  				type: "publishers",
  				attributes: {
  					name: "Maning"
  				}
  			}
  		}

  		post '/publishers',
  		params: publisher.to_json,
  		headers: {'Content-Type': 'application/json'}

  		expect(response.status).to eq 201
  		body = JSON.parse(response.body)
  		publisher_name = body['data']['attributes']['name']
  		expect(publisher_name) == 'Maning'
  	end
  end

  describe "PUT /publishers/:id" do
  	it "updates the specific publisher" do
  		FactoryGirl.create :publisher, name: 'Maning', id: 1

  		publisher ={
  			data:{
  				type: "publishers",
  				attributes: {
  					name: "Amazon"
  				}
  			}
  		}

  		put '/publishers/1',
  		params: publisher.to_json,
  		headers: {'Content-Type': 'application/json'}

  		expect(response.status).to eq 200

			body = JSON.parse(response.body)
			# puts body.inspect
			publisher_name = body['data']['attributes']['name']
			expect(publisher_name) == 'Amazon'
  	end
  end

  describe "DELETE /publishers/:id" do
  	it "deletes the specific publisher" do
  		FactoryGirl.create :publisher, name: 'Maning', id: 1

  		delete '/publishers/1'

  		expect(response.status).to eq 204
  	end
  end
end
