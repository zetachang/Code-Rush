require "spec_helper"
describe AssignItemsController do
  describe "Requesting #hand_in GET" do
    before(:each) do
      assign = mock_model(Assignment)
      Assignment.stub(:find).and_return(assign)
      item = mock_model(AssignItem)
      item.stub(:assign_type).and_return('CODE')
      AssignItem.stub(:find).and_return(item)
      controller.stub(:current_oier).and_return(Oier.new(:name => 'foo'))
      user = User.new(:username => 'foo',:password => 'pwd')
      sign_in user
    end
    
    it "should render hand_in_code template if its first time hand-in" do
      put :hand_in, :assignment_id => 1, :id => 1
      response should render_template(:hand_in_code)
    end
    
    it "should find existing code if its not first time hand-in"
    it "should render customized tutrorial page"
  end
end