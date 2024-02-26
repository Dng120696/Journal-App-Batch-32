class Task < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :title, presence: true,
                      length: {minimum:3,maximum:100}
  validates :description, presence: true,
                      length: {maximum:100}
  validates :due_date, presence: true

end
