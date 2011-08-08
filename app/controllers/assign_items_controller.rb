class AssignItemsController < ApplicationController
  load_resource :instance_name => :item, :class => AssignItem 
  authorize_resource :instance_name => :item, :class => AssignItem, :except => [:new, :create]
   
  def new
    @assignment = Assignment.find(params[:assignment_id])
    if @assignment.setter != current_user.username
      redirect_to :root, :alert => 'Permission Denied'
    end
  end
  
  def destroy
    @assignment = Assignment.find(params[:assignment_id])
    @item.destroy
    redirect_to @assignment
  end
  
  
  def show
  end
  
  def create
    @assignment = Assignment.find(params[:assignment_id])
    if @assignment.setter != current_user.username
      redirect_to :root, :alert => 'Permission Denied'
    end
    @assignment.items << @item
    if @item.save
      flash[:notice] = 'Item was successfully created.'
      redirect_to @assignment
    else
      render :action => "new" 
    end
  end
  
  def edit
    #@item = AssignItem.find(params[:id])
    #authorize! :hand_in, @item
    @assignment = Assignment.find(params[:assignment_id])
    #flash.now.notice = "#{@item.id}"
  end
  
  def update
    #@item = AssignItem.find(params[:id])
    @assignment = Assignment.find(params[:assignment_id])
    
    #fix the corresponding code
    @item.codes.each do |code|
      code.title = @item.title
      code.save
    end
    
    if @item.update_attributes(params[:assign_item])
      redirect_to @assignment , :notice => "Successfully Updated!" 
    else
      render :action => "edit" 
    end
  end
  
  def hand_in
    @code ||= @item.codes.find_by_oier_id(current_oier)
    unless @code
      @code = Code.create(:title => @item.title, :description => @item.description, :oier => current_oier)      
      @code.tag_list << @item.ojtype << @item.ojtype + @item.prob_num
      @item.codes << @code 
    end
    render :template => 'codes/edit'
  end

end
