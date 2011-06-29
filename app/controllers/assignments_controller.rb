class AssignmentsController < ApplicationController
  load_and_authorize_resource :except => [:index,:show] 
  #check_authorization
  def index
    #@assignments = Assignment.order("created_at DESC").all.reject{|a| a.due?}
    #@due_assignments = Assignment.all.select{|a| a.due?}
    @assignments = Assignment.all
  end

  def show
    @assignment = Assignment.find(params[:id])
    @assigned_to = @assignment.assigned_to
    @items = @assignment.items
    #flash.now.notice = @assigned_to[0].name
  end

  def new
    @assignment = Assignment.new
  end

  def create
    #@assignment = Assignment.new(params[:id])
    @assignment.setter = current_user.username
    if @assignment.save
      redirect_to @assignment, :notice => 'Assignment successfully created!'
    else
      render :action => "new"  
    end
  end
  
  def edit
    @assignment = Assignment.find(params[:id])
    #authorize! :edit, @assignment
  end
  
  def update
    @assignment = Assignment.find(params[:id])
    if @assignment.update_attributes(params[:assignment])
      redirect_to @assignment, :notice => 'Assignment was successfully updated.'
    else
      render :action => 'edit'
    end
  end

  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy
    redirect_to :action => "index" 
  end
end
