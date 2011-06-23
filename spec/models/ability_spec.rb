require "spec_helper"
require "cancan/matchers"

describe Ability do
  
  let(:user) { User.new(:username => 'foo')}
  let(:assign) { Assignment.new }
  let(:item) { AssignItem.new }
  
  describe "Oier" do
    it "can hand in assign_item he is assigned to" do
      user.oier = Oier.new(:name => 'foo')
      assign.items << item
      item.assignment = assign
      assign.assigned_to << user.oier
      ab = Ability.new(user)
      ab.should be_able_to(:hand_in, item)
    end    
  end
  
  describe "Teacher" do
    it "can modify assignment" do
      ab = Ability.new(user)
      ab.should be_able_to(:modify, Assignment.new(:setter => 'foo' ))
    end
    
    it "cannot modify assignment not belonging to him" do
      ab = Ability.new(user)
      ab.should_not be_able_to(:modify, Assignment.new(:setter => "bar"))
    end
  end
end  