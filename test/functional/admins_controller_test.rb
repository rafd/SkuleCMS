require 'test_helper'

class AdminsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin" do
    assert_difference('Admin.count') do
      post :create, :admin => { }
    end

    assert_redirected_to admin_path(assigns(:admin))
  end

  test "should show admin" do
    get :show, :id => admins(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => admins(:one).to_param
    assert_response :success
  end

  test "should update admin" do
    put :update, :id => admins(:one).to_param, :admin => { }
    assert_redirected_to admin_path(assigns(:admin))
  end

  test "should destroy admin" do
    assert_difference('Admin.count', -1) do
      delete :destroy, :id => admins(:one).to_param
    end

    assert_redirected_to admins_path
  end
end
