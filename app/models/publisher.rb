class Publisher < ApplicationRecord
	validates :name, presence: true, uniqueness: true, length: {minimum: 5}
end
