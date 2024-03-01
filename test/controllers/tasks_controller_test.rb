require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should get index" do
    category = categories(:category_one) # Fetching a category fixture
    get category_tasks_url(category_id: category.id)
    assert_response :success
  end
end
