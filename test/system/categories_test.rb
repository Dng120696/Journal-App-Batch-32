require "application_system_test_case"

class CategoriesTest < ApplicationSystemTestCase
  setup do
    @user = users(:user_one)
    @category = categories(:category_one)

    visit new_user_session_path

    fill_in "user[email]", with: @user.email
    fill_in "user[password]", with: 'password'

    click_on "Log in"

    assert_text "Signed in successfully.",wait: 10
  end

  test "creating a new category" do
    click_link 'Add Category'

    fill_in "Name", with: "System Testing"
    click_on "Create"

    assert_equal categories_path, current_path
    assert_text "Category was created successfully."
  end


  test "edit and update category name" do
    visit edit_category_path(@category)

    fill_in "category[name]", with: "Updated Category Name"
    click_on "Update"

    assert_equal categories_path, current_path
    assert_text 'Category was updated successfully.',wait: 10

  end
  test "delete category" do
    accept_confirm do
      click_button 'Delete Category',class: "delete-category-#{@category.id}-button"
    end
    assert_equal categories_path, current_path
    assert_text 'Category was deleted successfully.',wait: 10
  end

end
