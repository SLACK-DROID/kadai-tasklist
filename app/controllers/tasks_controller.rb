class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    if logged_in?
      @tasks = current_user.tasks.all.page(params[:page]).per(10)
    end
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Task が正常に保存されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が保存されませんでした'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = 'Task は正常に保存されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は保存されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
private

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def set_task
    @task = Task.find(params[:id])
    
    redirect_to root_url if @task.user != current_user
  end
end