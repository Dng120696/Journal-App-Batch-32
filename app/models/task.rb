class Task < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :title, presence: true,
                      length: {minimum:6,maximum:50}
  validates :description, presence: true,
                      length: {minimum:6,maximum:100}
  validates :due_date, presence: true

end
