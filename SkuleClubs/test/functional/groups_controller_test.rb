require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create groups" do
    assert_difference('Groups.count') do
      post :create, :groups => { }
    end

    assert_redirected_to groups_path(assigns(:groups))
  end

  test "should show groups" do
    get :show, :id => groups(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => groups(:one).to_param
    assert_response :success
  end

  test "should update groups" do
    put :update, :id => groups(:one).to_param, :groups => { }
    assert_redirected_to groups_path(assigns(:groups))
  end

  test "should destroy groups" do
    assert_difference('Groups.count', -1) do
      delete :destroy, :id => groups(:one).to_param
    end

    assert_redirected_to groups_path
  end
end
