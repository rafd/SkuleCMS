require 'test_helper'

class LargePostsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:large_posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create large_post" do
    assert_difference('LargePost.count') do
      post :create, :large_post => { }
    end

    assert_redirected_to large_post_path(assigns(:large_post))
  end

  test "should show large_post" do
    get :show, :id => large_posts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => large_posts(:one).to_param
    assert_response :success
  end

  test "should update large_post" do
    put :update, :id => large_posts(:one).to_param, :large_post => { }
    assert_redirected_to large_post_path(assigns(:large_post))
  end

  test "should destroy large_post" do
    assert_difference('LargePost.count', -1) do
      delete :destroy, :id => large_posts(:one).to_param
    end

    assert_redirected_to large_posts_path
  end
end
