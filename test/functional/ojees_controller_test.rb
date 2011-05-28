require 'test_helper'

class OjeesControllerTest < ActionController::TestCase
  setup do
    @ojee = ojees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ojees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ojee" do
    assert_difference('Ojee.count') do
      post :create, :ojee => @ojee.attributes
    end

    assert_redirected_to ojee_path(assigns(:ojee))
  end

  test "should show ojee" do
    get :show, :id => @ojee.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @ojee.to_param
    assert_response :success
  end

  test "should update ojee" do
    put :update, :id => @ojee.to_param, :ojee => @ojee.attributes
    assert_redirected_to ojee_path(assigns(:ojee))
  end

  test "should destroy ojee" do
    assert_difference('Ojee.count', -1) do
      delete :destroy, :id => @ojee.to_param
    end

    assert_redirected_to ojees_path
  end
end
