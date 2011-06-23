require "spec_helper"
describe Assignment do
  let(:assignment){Assignment.new}
  it "should be created by verified person"
  
  it "should be locked after the due time" do
    assignment.due_time = DateTime.yesterday
    assignment.locked?.should be_true
  end
end