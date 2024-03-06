require "application_system_test_case"

class CategoriesTest < ApplicationSystemTestCase
  setup do
    @user = users(:user_one)
    @category = categories(:category_one)
    @task = tasks(:task_one)

    visit new_user_session_path

    fill_in "user[email]", with: @user.email
    fill_in "user[password]", with: 'password'

    click_on "Log in"

    assert_text "Signed in successfully.",wait: 10
  end
  test "Clicking 'New Task' within the chosen category will allow you to create a new task. Upon creation, it will redirect you to the list of tasks within that category" do
    within(".category-#{@category.id}") do
      click_link "New Task"
    end

    fill_in "Title", with: "System Testing"
    fill_in "Description", with: "Working on my System Testing"
    fill_in "Due date", with: Date.today

    click_on "Create"

    assert_equal category_tasks_path(@category), current_path
    assert_text "Task was created successfully."

  end
  test "edit and update selected task" do
    within(".task-link-#{@task.id}") do
    find(:css, 'a i.fa-solid.fa-pen').click
  end

    fill_in "Title", with: "System Testing-edited"
    fill_in "Description", with: "Working on my System Testing"
    fill_in "Due date", with: Date.today
    click_on "Update"


    assert_text 'Task was updated successfully.',wait: 10

  end
  test "delete the selected task within category" do
    within(".task-link-#{@task.id}") do
    accept_confirm do
      find(:css, 'form button i.fa-solid.fa-trash-can').click
    end
  end

    assert_equal categories_path, current_path
    assert_text 'Task was Deleted successfully.',wait: 10

  end


end
