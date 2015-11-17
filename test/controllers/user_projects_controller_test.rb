require 'test_helper'

class UserProjectsControllerTest < ActionController::TestCase
  setup do
    @user_project = user_projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_project" do
    assert_difference('UserProject.count') do
      post :create, user_project: { project_id: @user_project.project_id, user_id: @user_project.user_id }
    end

    assert_redirected_to user_project_path(assigns(:user_project))
  end

  test "should show user_project" do
    get :show, id: @user_project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_project
    assert_response :success
  end

  test "should update user_project" do
    patch :update, id: @user_project, user_project: { project_id: @user_project.project_id, user_id: @user_project.user_id }
    assert_redirected_to user_project_path(assigns(:user_project))
  end

  test "should destroy user_project" do
    assert_difference('UserProject.count', -1) do
      delete :destroy, id: @user_project
    end

    assert_redirected_to user_projects_path
  end
end
