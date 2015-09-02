require 'test_helper'

class RemoteProjectsControllerTest < ActionController::TestCase
  setup do
    @remote_project = remote_projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:remote_projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create remote_project" do
    assert_difference('RemoteProject.count') do
      post :create, remote_project: {  }
    end

    assert_redirected_to remote_project_path(assigns(:remote_project))
  end

  test "should show remote_project" do
    get :show, id: @remote_project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @remote_project
    assert_response :success
  end

  test "should update remote_project" do
    patch :update, id: @remote_project, remote_project: {  }
    assert_redirected_to remote_project_path(assigns(:remote_project))
  end

  test "should destroy remote_project" do
    assert_difference('RemoteProject.count', -1) do
      delete :destroy, id: @remote_project
    end

    assert_redirected_to remote_projects_path
  end
end
