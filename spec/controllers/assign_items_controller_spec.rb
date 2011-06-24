require "spec_helper"

describe AssignItemsController do
  
  describe "Requesting #hand_in PUT" do
    describe "Hand in code" do
      before(:each) do
        @item = AssignItem.new(:assign_type => 'CODE',:title => "Haha",:description => 'Haha')
        controller.stub(:authorize!).and_return(true)
        controller.stub!(:current_oier).and_return(Oier.new(:name => 'foo'))
        AssignItem.stub(:find).and_return(@item)
      end
      
      it "should be successful" do 
        put :hand_in, :assignment_id => 1, :id =>1
        response.should be_success
      end
      it "should find an item" do
        AssignItem.should_receive(:find).and_return(@item)
        put :hand_in, :assignment_id => 1, :id => 1
      end
      it "should be CODE assign_type" do
        @item.assign_type.should == 'CODE'
        put :hand_in, :assignment_id => 1, :id => 1
      end
      it "should render hand_in_code template" do
        put :hand_in, :assignment_id => 1, :id => 1
        response.should render_template(:hand_in_code)
      end
      
      context "first time hand-in CODE" do
        it "should find that it's first handed-in" do
          @item.codes.should_receive(:find_by_creator).with('foo').and_return(nil)
          put :hand_in, :assignment_id => 1, :id => 1 
        end
        
        it "should create new code" do
          code = Code.new(:title => 'Haha', :description => 'Haha')
          Code.should_receive(:create).with(:title => 'Haha', 
          :description => 'Haha', :creator => 'foo').and_return(code)
          put :hand_in, :assignment_id => 1, :id => 1
        end
      end
      
      context "not first time hand-in CODE" do
        it "should find existing code" do
          code = Code.new(:creator => 'foo')
          @item.codes << code
          @item.codes.should_receive(:find_by_creator).and_return(code)
          put :hand_in, :assignment_id => 1, :id => 1
        end
        
      end
    end
    describe "Hand in Tutorial" do
      before(:each) do
        @item = AssignItem.new(:assign_type => 'TEXT',:title => "Haha",:description => 'Haha')
        controller.stub(:authorize!).and_return(true)
        controller.stub!(:current_oier).and_return(Oier.new(:name => 'foo'))
        AssignItem.stub(:find).and_return(@item)
        @tutorial = Tutorial.new(:title => 'Haha')
        @item.tutorial = @tutorial
      end
      it "should be TEXT assign_type" do
        @item.assign_type.should == 'TEXT'
        put :hand_in, :assignment_id => 1, :id => 1
      end
      it "should find the correspond tutorial" do
        @item.should_receive(:tutorial).and_return(@tutorial)
        put :hand_in, :assignment_id => 1, :id => 1 
      end
      
      context "first time reading" do
        it "should find its first time reading" do
          @tutorial.reader_list.include?('foo').should be_false
          put :hand_in, :assignment_id => 1, :id => 1
        end
        it "should assign the reader to the tutorial" do
          @tutorial.reader_list.should_receive(:push).with('foo')
          put :hand_in, :assignment_id => 1, :id => 1
        end
        it "should save the tutorial" do
          @tutorial.should_receive(:save).and_return(true)
          put :hand_in, :assignment_id => 1, :id => 1
        end
        it "should render customized tutrorial page" do
          put :hand_in, :assignment_id => 1, :id => 1
          response.should render_template(:read_tutorial)
        end
      end
      
      context "not first time readging" do
        it "should find its not first time reading" do
          @tutorial.reader_list << 'foo'
          @tutorial.reader_list.include?('foo').should be_true
          put :hand_in, :assignment_id => 1, :id => 1
        end
        it "should render the customized tutorial page" do
          put :hand_in, :assignment_id => 1, :id => 1
          response.should render_template(:read_tutorial)
        end
      end
    end
  end
end