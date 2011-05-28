require 'test_helper'

class OiersControllerTest < ActionController::TestCase
  setup do
    @oier = oiers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:oiers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create oier" do
    assert_difference('Oier.count') do
      post :create, :oier => @oier.attributes
    end

    assert_redirected_to oier_path(assigns(:oier))
  end

  test "should show oier" do
    get :show, :id => @oier.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @oier.to_param
    assert_response :success
  end

  test "should update oier" do
    put :update, :id => @oier.to_param, :oier => @oier.attributes
    assert_redirected_to oier_path(assigns(:oier))
  end

  test "should destroy oier" do
    assert_difference('Oier.count', -1) do
      delete :destroy, :id => @oier.to_param
    end

    assert_redirected_to oiers_path
  end
end
