class AssignItemsController < ApplicationController
  load_resource :instance_name => :item, :class => AssignItem 
  authorize_resource :instance_name => :item, :class => AssignItem 
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
    if @item.assign_type == 'CODE'
      #find if there exist a code first
      @code ||= @item.codes.find_by_creator(current_oier.name)
      if not @code
        @code = Code.create(:title => @item.title, :description => @item.description, :creator => current_oier.name)      
        @item.codes << @code 
      end
      render "hand_in_code"
    elsif @item.assign_type == 'TEXT'
      @tutorial = @item.tutorial 
      if @tutorial.reader_list.include?('foo')
        flash.now[:notice] = "You have already handed in this item!"
      else
        @tutorial.reader_list.push(current_oier.name)
        @tutorial.save
      end
      render "read_tutorial"
    end
    
  end

end
