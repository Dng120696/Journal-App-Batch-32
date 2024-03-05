require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do
    @user = users(:user_one)
  end

  test "name should be unique" do
    @category= @user.categories.new(name: 'Testing')
    @category.save
    @category2 = @user.categories.new(name: 'Testing')
    assert_not @category2.valid?
  end

  test "should not save Category without name" do
    @category = @user.categories.new(name: nil)
    assert_not @category.save
  end

  test "should not save Category with name longer than 20 characters" do
    @category = @user.categories.new(name: "a"*21)
    assert_not @category.save
  end



end
