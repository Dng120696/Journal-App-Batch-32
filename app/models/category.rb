class Category < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, length: {minimum:3,maximum:50}

end
