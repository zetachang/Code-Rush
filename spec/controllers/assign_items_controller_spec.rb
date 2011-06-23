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
        @item.should_receive(:assign_type).and_return('CODE')
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
        @item = AssignItem.new(:assign_type => 'TEXT')
        AssignItem.stub(:find).and_return(@item)
      end
      it "should be TEXT assign_type" do
        
        @item.should_receive(:assign_type).and_return('TEXT')
        put :hand_in, :assignment_id => 1, :id => 1
      end
      it "should render customized tutrorial page"
    end
  end
end