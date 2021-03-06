require 'rails_helper'

RSpec.describe Book, :type => :model do
  it { should respond_to :title }
  it { should validate_presence_of :title }
  it { should validate_length_of(:title).is_at_least(5)}
  
  it { should respond_to :isbn }
  it { should validate_presence_of :isbn }
  it { should validate_length_of(:isbn).is_at_least(10)}

 #  subject {Book.new(title: '
 	# Rails 4 in Action', isbn: '1234567890', cover: 'cover.pg')}
	# it { should validate_uniqueness_of :isbn}

  it { should respond_to :cover }
  it { should validate_presence_of :cover }
end
