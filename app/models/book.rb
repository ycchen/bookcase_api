class Book < ApplicationRecord
  belongs_to :publisher
  has_many :publications
  has_many :authors, through: :publications

  validates :title, presence: true, length: {minimum: 5}
  validates :isbn, presence: true, length: {minimum: 10}, uniqueness: { case_sensitive: false }
  validates :cover, presence: true
  
end
