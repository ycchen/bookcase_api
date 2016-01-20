require 'rails_helper'

RSpec.describe "Books", :type => :request do
	before(:each) do
		@publisher = FactoryGirl.create :publisher, name: 'Pragmatic Bookshelf'
	end

  describe "GET /books" do
    it "returns all the books" do
    	
    	FactoryGirl.create :book, title: 'Rails 4 in Action', isbn: '99988776655', publisher: @publisher
    	FactoryGirl.create :book, title: 'Agile Web Development with Rails 4', isbn: '9876543210', publisher: @publisher

      get books_path

      expect(response).to have_http_status(200)

      body = JSON.parse(response.body)

      # puts body.inspect
      book_titles = body['data'].map{|b| b['attributes']['title'] }
      # puts book_titles.inspect
      expect(book_titles).to match_array(['Rails 4 in Action', 'Agile Web Development with Rails 4'])
    end
  end

  describe "GET /books/:id" do
  	it "return the specific book" do
  		publisher = FactoryGirl.create :publisher, name: 'Manning'
  		FactoryGirl.create :book, title: 'Rails 4 in Action', id: 1, isbn: '9988776655', publisher: publisher

  		get books_path(1)

  		body = JSON.parse(response.body)
  		# puts body.inspect
  		book_title =  body['data'][0]['attributes']['title']
  		# puts book_title
  		expect(book_title) == 'Rails 4 in Action'
  	end
  end

	describe "POST /books" do
  	it "create the specific book" do
  		# publisher = FactoryGirl.create :publisher, name: 'Manning'
  		book = {
  			data:{
  				type: "books",
  				id: 1,
  				attributes:{
  					title: "Rails 4 in Action",
  					isbn: "9988776655",
  					cover: "cover.png",
  					publisher_id: @publisher.id
  				}
  			}
  		}
  		puts book.inspect

  		post '/books',
  			params: book.to_json,
  			headers: {'Content-type': 'application/json'}
			
			# puts response.status.inspect
			expect(response.status).to eq 201
  		
  		body = JSON.parse(response.body)
  		# puts body.inspect
  		book_title = body['data']['attributes']['title']

  		expect(book_title) == 'Rails 4 in Action'
  	end
  end  
 
	describe "PUT /books/:id" do
  	it "updates the specific book" do
  		FactoryGirl.create :book, title: 'Rails 4 in Action', isbn: '1234567890', cover: 'test.png', publisher: @publisher
  		book = {
  			data:{
  				type: "books",
  				id: 1,
  				attributes:{
  					title: "Agile Web Development with Rails 4",
  					isbn: "9988776655",
  					cover: "cover.png",
  					publisher_id: @publisher.id
  				}
  			}
  		}

  		put '/books/1',
  			params: book.to_json,
  			headers: {'Content-type': 'application/json'}

			# puts response.status
			expect(response.status).to eq 200
			body = JSON.parse(response.body)

			# puts body.inspect
			book_title = body['data']['attributes']['title']
			expect(book_title) == "Agile Web Development with Rails 4"
  	end
  end

	describe "DELETE /books/:id" do
		it "deletes the specific book" do
			FactoryGirl.create :book, title: 'Rails 4 in Action', isbn: '1234567890', cover: 'test.png', publisher: @publisher

			delete '/books/1'

			expect(response.status).to eq 204
		end
	end

 # describe "" do
 #  	it "" do
 #  	end
 #  end
end

