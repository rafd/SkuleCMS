require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pages" do
    assert_difference('Pages.count') do
      post :create, :pages => { }
    end

    assert_redirected_to pages_path(assigns(:pages))
  end

  test "should show pages" do
    get :show, :id => pages(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => pages(:one).to_param
    assert_response :success
  end

  test "should update pages" do
    put :update, :id => pages(:one).to_param, :pages => { }
    assert_redirected_to pages_path(assigns(:pages))
  end

  test "should destroy pages" do
    assert_difference('Pages.count', -1) do
      delete :destroy, :id => pages(:one).to_param
    end

    assert_redirected_to pages_path
  end
end
