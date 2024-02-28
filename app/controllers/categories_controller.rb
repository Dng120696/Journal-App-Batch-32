class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_category, only: [:show,:edit,:update,:destroy,:delete_all_tasks]
  def new
    @category = current_user.categories.new
  end
  def index
    @categories = current_user.categories
  end
  def show; end
  def edit; end

  def update
    old_category_attr = @category.attributes
    if @category.update(category_params)
      if old_category_attr != @category.attributes
         flash[:notice] = 'Category was updated successfully.'
      else
        flash[:notice] = 'No Changes were made.'
      end
        redirect_to categories_path
    else
        redirect_to 'edit'
    end
  end
  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      flash[:notice] = 'Category was created successfully.'
      redirect_to categories_path
    else
      render 'new'
    end
  end
  def destroy
    @category.destroy
    flash[:notice] = 'Category was deleted successfully.'
    redirect_to categories_path
  end

  def delete_all_tasks
    if @category.tasks.count > 0
    @category.tasks.destroy_all
    flash[:notice] = 'All tasks were deleted successfully.'
  else
    flash[:notice] = 'No tasks to be deleted.'
  end

  redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
  def find_category
    @category = current_user.categories.find(params[:id])
  end
end
