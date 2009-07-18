require 'test_helper'

class SmallPostsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:small_posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create small_post" do
    assert_difference('SmallPost.count') do
      post :create, :small_post => { }
    end

    assert_redirected_to small_post_path(assigns(:small_post))
  end

  test "should show small_post" do
    get :show, :id => small_posts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => small_posts(:one).to_param
    assert_response :success
  end

  test "should update small_post" do
    put :update, :id => small_posts(:one).to_param, :small_post => { }
    assert_redirected_to small_post_path(assigns(:small_post))
  end

  test "should destroy small_post" do
    assert_difference('SmallPost.count', -1) do
      delete :destroy, :id => small_posts(:one).to_param
    end

    assert_redirected_to small_posts_path
  end
end
