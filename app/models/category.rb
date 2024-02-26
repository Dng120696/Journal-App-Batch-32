class Category < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  VALID_EMAIL_REGEX = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :name, presence: true,
                      uniqueness: { case_sensitive: false },
                      length: {minimum:6,maximum:100}

end
