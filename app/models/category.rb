class Category < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates :name, presence: true,
                      length: {minimum:6,maximum:100}

end
