require 'test_helper'

class DownloadFoldersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:download_folders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create download_folder" do
    assert_difference('DownloadFolder.count') do
      post :create, :download_folder => { }
    end

    assert_redirected_to download_folder_path(assigns(:download_folder))
  end

  test "should show download_folder" do
    get :show, :id => download_folders(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => download_folders(:one).to_param
    assert_response :success
  end

  test "should update download_folder" do
    put :update, :id => download_folders(:one).to_param, :download_folder => { }
    assert_redirected_to download_folder_path(assigns(:download_folder))
  end

  test "should destroy download_folder" do
    assert_difference('DownloadFolder.count', -1) do
      delete :destroy, :id => download_folders(:one).to_param
    end

    assert_redirected_to download_folders_path
  end
end
