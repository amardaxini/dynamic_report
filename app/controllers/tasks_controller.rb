class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.xml
  before_filter :load_project,:except => 'index'
  def index
    @projects = Project.all
    if params[:project_id].blank?
      @tasks = Task.all
      @project_id = ""
    else
      @project = Project.find(params[:project_id])
      @project_id = @project.id
      @tasks =  @project.tasks
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = @project.tasks.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = @project.tasks.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = @project.tasks.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = @project.tasks.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to(project_path(@project), :notice => 'Task was successfully created.') }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = @project.tasks.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html {redirect_to(project_path(@project), :notice => 'Task was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = @project.tasks.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(project_tasks_url(@project)) }
      format.xml  { head :ok }
      format.js   { render :nothing => true }
      # or format.js
    end
  end

  def update_task_status
    @task = @project.tasks.find(params[:id])
    @task.status = @task.status == Task::STATUSES[0] ? Task::STATUSES[1] : Task::STATUSES[0]
    @task.save
    respond_to do |format|
      format.js
    end
  end

  private
  def load_project
    @project = Project.find(params[:project_id])
  end
end
