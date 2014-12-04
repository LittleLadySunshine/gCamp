class CommentsController < ApplicationController
  before_action do
    @task = Task.find(params[:task_id])
    @project = Project.find(params[:project_id])
  end

  def create
    comment_params = params.require(:comment).permit(:description)
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.task_id = @task.id
    @comment.save
    redirect_to project_task_path(@project, @task), notice: "Comment was successfully created."
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(params.require(:comment).permit(:description))
      redirect_to @comment, notice: "Comment was successfully edited."
    else
      render :edit
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :task_id, :user_id)
    .merge({:task_id => params[:task_id], :user_id => session[:user_id]})
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to comment_path, notice: "Comment was successfully deleted."
  end

end
