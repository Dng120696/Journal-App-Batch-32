class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_category_task, only: [:task_today_completed,:category_task_completed, :edit,:delete_task_today]
  before_action :find_category, only: [:create,:new,:index,:update,:active_category_tasks,:completed_category_tasks,:clear_completed_category_task]

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
    @task = @category.tasks.find(params[:id])
    old_task_attr = @task.attributes
    if @task.update(task_params)
      if @task.attributes != old_task_attr
        flash[:notice] = 'Task was updated successfully.'
      else
        flash[:notice] = 'No changes were made.'
      end
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def index
    @tasks = @category.tasks
    @tasks = @tasks.where(is_completed: true) if params[:completed]
    @tasks = @tasks.where(is_completed: false) if params[:active]


  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy
    flash[:notice] = 'Task was Deleted successfully.'
    redirect_to categories_path

  end
  def active_category_tasks
    @tasks = @category.tasks.where(is_completed: false)
    render 'index'
  end

  def completed_category_tasks
    @tasks = @category.tasks.where(is_completed: true)
    render 'index'
  end
  def clear_completed_category_task
    if @category.tasks.where(is_completed:true).count > 0
      @category.tasks.where(is_completed:true).destroy_all
    flash[:notice] = 'Task was Deleted successfully.'
    else
      flash[:notice] = 'No Task Is Completed.'
    end
    redirect_to category_tasks_path
  end
  def today
    @tasks = current_user.tasks.where(due_date: Date.today)
  end
  def task_today_completed
    @task.update(task_completed_params)
      flash[:notice] = 'Task was updated successfully.'
      redirect_to tasks_today_path
  end

  def delete_task_today
    @task.destroy
    flash[:notice] = 'Task was Deleted successfully.'
    redirect_to categories_path
  end

  def active_today
    @tasks = current_user.tasks.where(due_date: Date.today, is_completed: false)
    render 'today'
  end

  def completed_today
    @tasks = current_user.tasks.where(due_date: Date.today, is_completed: true)
    render 'today'
  end

  def clear_completed_today
    if current_user.tasks.where(due_date: Date.today, is_completed: true).count > 0
      @tasks = current_user.tasks.where(due_date: Date.today, is_completed: true).destroy_all
      flash[:notice] = 'Completed tasks cleared successfully.'
    else
      flash[:notice] = 'No completed tasks to clear.'
    end
    redirect_to tasks_today_path
  end
  def category_task_completed
    @task.update(task_completed_params)
      flash[:notice] = 'Task was updated successfully.'
      redirect_to category_tasks_path(@task.category)
  end

  private
  def find_category
    @category = current_user.categories.find(params[:category_id])
  end
  def find_category_task
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
