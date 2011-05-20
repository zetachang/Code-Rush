require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def setup
    @comment = Comment.new
    @comment.valid?
  end
  
  test "should belong to post" do
    assert_equal( posts(:one), comments(:one).post )
  end

  test "should not be valid without name" do
    assert_equal(@comment.errors.on(:name), "can't be blank")
  end

  test "should not be valid without body" do
    assert_equal(@comment.errors.on(:body), "can't be blank")
  end
end
