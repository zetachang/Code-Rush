require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def setup
    @post = Post.new
    @post.valid?
  end
  test "should not be valid without title" do
      assert_equal @post.errors.on(:title), "can't be blank"
  end
end
