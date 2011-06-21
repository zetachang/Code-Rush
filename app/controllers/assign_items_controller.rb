class AssignItemsController < ApplicationController
  authorize_resource :instance_name => :item, :class => :assign_item 
  def new
    @item = AssignItem.new
    @assignment = Assignment.find(params[:assignment_id])
    flash.now.notice = @assignment.title
  end
  
  def destroy
    @assignment = Assignment.find(params[:assignment_id])
    @item = AssignItem.find(params[:id])
    @item.destroy
    redirect_to @assignment
  end
  
  # This is on valiable to "User"
  def show
    @item = AssignItem.find(params[:id])  
  end
  
  def create
    @item = AssignItem.new(params[:assign_item])
    @assignment = Assignment.find(params[:assignment_id])
    @assignment.items << @item
    if @item.save
      flash[:notice] = 'Item was successfully created.'
      redirect_to @assignment
    else
      render :action => "new" 
    end
  end
  
  def edit
    @item = AssignItem.find(params[:id])
    #authorize! :hand_in, @item
    @assignment = Assignment.find(params[:assignment_id])
    #flash.now.notice = "#{@item.id}"
  end
  
  def update
    @item = AssignItem.find(params[:id])
    @assignment = Assignment.find(params[:assignment_id])
    if @item.update_attributes(params[:assign_item])
      redirect_to @assignment , :notice => "Successfully Updated!" 
    else
      render :action => "edit" 
    end
  end
  
  def hand_in
    @item = AssignItem.find(params[:id])
    #authorize! :hand_in, @item
    if @item.assign_type == 'CODE'
      #find if there exist a code first
      @code ||= Code.find_by_creator(current_oier.name)
      if not @code
        @code = Code.create(:title => @item.title, :description => @item.description, :creator => current_oier.name)      
        @item.codes << @code 
      end
      render "hand_in_code"
    elsif @item.assigntype == 'TEXT'
      render "hand_in_text"
    end
    
  end

end
