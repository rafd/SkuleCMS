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

  test "should create update" do
    assert_difference('Update.count') do
      post :create, :update => { }
    end

    assert_redirected_to update_path(assigns(:update))
  end

  test "should show update" do
    get :show, :id => updates(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => updates(:one).to_param
    assert_response :success
  end

  test "should update update" do
    put :update, :id => updates(:one).to_param, :update => { }
    assert_redirected_to update_path(assigns(:update))
  end

  test "should destroy update" do
    assert_difference('Update.count', -1) do
      delete :destroy, :id => updates(:one).to_param
    end

    assert_redirected_to updates_path
  end
end
