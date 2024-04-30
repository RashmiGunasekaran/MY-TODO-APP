class TasksController < ApplicationController

   def index
      
      @tasks = Task.all

      if params[:status_filter].present?

      @tasks = Task.where(status: params[:status_filter])
   end
   end

   def show
      @tasks = Task.find_by(id: params[:id])
   end
   
   def new
      @task = Task.new
   end
   
   def edit
   end
   
   def create
   if !(Task.where(status: "to-do").count>=Task.count/2) && param[:status]=="to-do"

      @task = Task.new(task_params)
      respond_to do |format|
         if @task.save
            format.html { redirect_to @task, notice: 'Task was successfully created.' }
            format.json { render :show, status: :created, location: @task }
         else
            format.html { render :new }
            format.json { render json: @task.errors, status: :unprocessable_entity }
         end
      end
     else
      flash.alert = "Task not Created"
    end
      
   end

   def update
      respond_to do |format|
         if @task.update(task_params)
            format.html { redirect_to @task, notice: 'Task was successfully updated.' }
            format.json { render :show, status: :ok, location: @task }
         else
            format.html { render :edit }
            format.json { render json: @task.errors, status: :unprocessable_entity }
         end
      end
      
   end
   
   def destroy
      @task = Task.find_by(id: params[:id])
      @task.destroy
         respond_to do |format|
         format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
         format.json { head :no_content }
      end
   end
   
   private
   def set_task
      @task = Task.find(params[:id])
   end

   def task_params
      params.require(:task).permit(:title, :description, :status)
   end
end
