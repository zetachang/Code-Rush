class AssignmentsController < ApplicationController
  def index
    @assignments = Assignment.all
    render
  end

  def show
    @assignment = Assignment.find(params[:id])
  end

  def edit
    @assignment = Assignment.find(params[:id])
  end

  def new
    @assignment = Assignment.new
  end

  def destroy
    assignment = Assignment.find(params[:id])
    assignment.destroy
    redirect_to :action => "index" 
  end

  def update
    @assignment = Assignment.find(params[:id])
    if @assignment.update_attributes(params[:assignment])
      redirect_to @assignment, :notice => 'Assignment was successfully updated.'
    else
      render :action => 'edit'
    end
  end

  def create
    @assignment = Assignment.new(params[:assignment])
    if @assignment.save
      redirect_to @assignment, :notice => 'Assignment successfully created!'
    else
      render :action => "new"  
    end
  end

end
