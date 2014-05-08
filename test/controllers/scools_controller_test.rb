require 'test_helper'

class ScoolsControllerTest < ActionController::TestCase
  setup do
    @scool = scools(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scools)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scool" do
    assert_difference('Scool.count') do
      post :create, scool: { scool: @scool.scool }
    end

    assert_redirected_to scool_path(assigns(:scool))
  end

  test "should show scool" do
    get :show, id: @scool
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scool
    assert_response :success
  end

  test "should update scool" do
    patch :update, id: @scool, scool: { scool: @scool.scool }
    assert_redirected_to scool_path(assigns(:scool))
  end

  test "should destroy scool" do
    assert_difference('Scool.count', -1) do
      delete :destroy, id: @scool
    end

    assert_redirected_to scools_path
  end
end
