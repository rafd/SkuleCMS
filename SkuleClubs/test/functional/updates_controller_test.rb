require 'test_helper'

class UpdatesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:updates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create updates" do
    assert_difference('Updates.count') do
      post :create, :updates => { }
    end

    assert_redirected_to updates_path(assigns(:updates))
  end

  test "should show updates" do
    get :show, :id => updates(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => updates(:one).to_param
    assert_response :success
  end

  test "should update updates" do
    put :update, :id => updates(:one).to_param, :updates => { }
    assert_redirected_to updates_path(assigns(:updates))
  end

  test "should destroy updates" do
    assert_difference('Updates.count', -1) do
      delete :destroy, :id => updates(:one).to_param
    end

    assert_redirected_to updates_path
  end
end
