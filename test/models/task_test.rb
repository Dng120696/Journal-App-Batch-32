require "test_helper"

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = users(:user_one)

  end

  test "should not create a Task without other property" do
    @task = @user.tasks.create(title:'task today')
    assert_not @task.save
  end

  test "should not save Task with description lesser than 3 characters" do
    @task = @user.tasks.create(description: "a"*3)
    assert_not @task.save
  end

end
