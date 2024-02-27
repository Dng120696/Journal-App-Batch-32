class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_task, only: [:today_task_completed,:toggle_task_completed, :edit,:toggle_completed,:delete_task_today]
  before_action :find_category, only: [:create,:new,:index,:active_tasks,:completed_tasks,:delete_completed_task]

  def new
    @task = @category.tasks.new
  end
  def show
    @task = current_user.tasks.find(params[:id])
  end
  def edit; end
  def create
    @task = @category.tasks.new(task_params)
    @task.user = current_user
    if @task.save
      flash[:notice] = 'Task was created successfully.'
      redirect_to category_tasks_path(@category)
    else
      render 'new'
    end
  end
  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = 'Task was updated successfully.'
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def index
    if @category.nil?
      redirect_to categories_path, alert: "Category not found."
    else

      @tasks = @category.tasks
      @tasks = @tasks.where(is_completed: true) if params[:completed]
      @tasks = @tasks.where(is_completed: false) if params[:active]
    end

  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy
    flash[:notice] = 'Task was Deleted successfully.'
    redirect_to categories_path

  end
  def active_tasks
    @tasks = @category.tasks.where(is_completed: false)
    render 'index'
  end

  def completed_tasks
    @tasks = @category.tasks.where(is_completed: true)
    render 'index'
  end
  def today
    @tasks = current_user.tasks.where(due_date: Date.today)
  end

  def active
    @tasks = current_user.tasks.where(due_date: Date.today, is_completed: false)
    render 'today'
  end

  def completed
    @tasks = current_user.tasks.where(due_date: Date.today, is_completed: true)
    render 'today'
  end

  def clear_completed
    if current_user.tasks.where(due_date: Date.today, is_completed: true).count > 0
      @tasks = current_user.tasks.where(due_date: Date.today, is_completed: true).destroy_all
      flash[:notice] = 'Completed tasks cleared successfully.'
    else
      flash[:notice] = 'No completed tasks to clear.'
    end
    redirect_to tasks_today_path
  end


  def delete_task_today
    @task.destroy
    flash[:notice] = 'Task was Deleted successfully.'
    redirect_to categories_path
  end
  def delete_completed_task
    if @category.tasks.where(is_completed:true).count > 0
      @category.tasks.where(is_completed:true).destroy_all
    flash[:notice] = 'Task was Deleted successfully.'
    else
      flash[:notice] = 'No Task Is Completed.'
    end
    redirect_to category_tasks_path
  end
  def today_task_completed
    @task.update(task_completed_params)
      flash[:notice] = 'Task was updated successfully.'
      redirect_to tasks_today_path
  end
  def toggle_task_completed
    @task.update(task_completed_params)
      flash[:notice] = 'Task was updated successfully.'
      redirect_to category_tasks_path(@task.category)
  end

  def toggle_completed
    @task.update(task_completed_params)
      flash[:notice] = 'Task was updated successfully.'
      redirect_to categories_path
  end



  private
  def find_category
    @category = current_user.categories.find(params[:category_id])
  end
  def find_task
    find_category
   @task = @category.tasks.find(params[:id])
 end

  def task_params
    params.require(:task).permit(:title, :description, :due_date,:is_completed)
  end
  def task_completed_params
    params.require(:task).permit(:is_completed)
  end
end
