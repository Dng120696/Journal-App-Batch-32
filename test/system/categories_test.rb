require "application_system_test_case"

class CategoriesTest < ActiveSupport::TestCase
  test "visiting index" do

    visit categories_url
    assert_selector "h1", text: "Categories"
  end

end
