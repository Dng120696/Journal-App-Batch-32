class Task < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :title, presence: true,
                      length: {minimum:6,maximum:50}
  validates :description, presence: true,
                      length: {minimum:6,maximum:100}
  validates :due_date, presence: true
  scope :completed, -> { where(is_completed: true) }
  scope :not_completed, -> { where(is_completed: false) }
  scope :today_task, -> { where(due_date: Date.today) }
  scope :today_task_completed, -> { where(due_date: Date.today, is_completed: true) }
  scope :today_task_not_completed, -> { where(due_date: Date.today, is_completed: false) }

end
