class CommentsController < ApplicationController

  before_action :logged_in?
  before_action do
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:task_id])
  end

  def index
    @comments = @task.comments.all
  end

  def new
    @comment = @task.comments.new
  end

  def show
  end

  def create
    @comment = @task.comments.new(params.require(:comment).permit(:description, :user_id, :task_id))
    @comment.user_id = current_user.id
    @comment.save
    redirect_to project_task_path(@project, @task), notice: "Comment was successfully created."
  end

end

private

  def comment_params
    params.require(:comment).permit(:comment, :task_id, :user_id)
    .merge({:task_id => params[:task_id], :user_id => session[:user_id]})
  end
