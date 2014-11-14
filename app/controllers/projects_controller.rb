class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]



  def index
    @project = Project.all
  end


  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @project = Project.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @project = Project.new(params.require(:project).permit(:name))
    if @project.save
        redirect_to @project, notice: "Project was successfully created."
      else
        render :new
      end
    end

  def update
    project_params = params.require(:project).permit(:name)
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to @project, notice "Project was succesfully edited"
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
    redirect_to @project, notice: 'Project was successfully destroyed.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :complete)
    end

end
