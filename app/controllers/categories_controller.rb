class CategoriesController < ApplicationController

  before_action :find_category, only: [:show,:edit,:update,:destroy,:delete_all_tasks]
  rescue_from ActiveRecord::RecordNotFound, with: :category_not_found

  def new
    @category = current_user.categories.new
  end
  def index
    search_params = params[:search]

    @categories = current_user.categories
    if search_params.present?
      @search_categories = @categories.select { |category| category.name.include?(search_params) }.paginate(page:params[:page],per_page:4)
    else
      @search_categories = @categories.paginate(page:params[:page],per_page:4)
    end
  end

  def show
    if @category.nil?
      redirect_to categories_path,alert: 'Categories not found!'
    end

  end
  def edit; end

  def update
    old_category_attr = @category.attributes
    if @category.update(category_params)
      if old_category_attr != @category.attributes
         flash[:notice] = 'Category was updated successfully.'
      else
        flash[:alert] = 'No Changes were made.'
      end
        redirect_to categories_path
    else
        redirect_to edit_category_path(@category)
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
    flash[:alert] = 'No tasks to be deleted.'
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
  def category_not_found
    # Redirect or render a view with a 404 error message
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end


end
