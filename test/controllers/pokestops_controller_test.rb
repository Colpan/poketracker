require 'test_helper'

class PokestopsControllerTest < ActionController::TestCase
  setup do
    @pokestop = pokestops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pokestops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pokestop" do
    assert_difference('Pokestop.count') do
      post :create, pokestop: { latitude: @pokestop.latitude, longitude: @pokestop.longitude, name: @pokestop.name, user_id: @pokestop.user_id }
    end

    assert_redirected_to pokestop_path(assigns(:pokestop))
  end

  test "should show pokestop" do
    get :show, id: @pokestop
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pokestop
    assert_response :success
  end

  test "should update pokestop" do
    patch :update, id: @pokestop, pokestop: { latitude: @pokestop.latitude, longitude: @pokestop.longitude, name: @pokestop.name, user_id: @pokestop.user_id }
    assert_redirected_to pokestop_path(assigns(:pokestop))
  end

  test "should destroy pokestop" do
    assert_difference('Pokestop.count', -1) do
      delete :destroy, id: @pokestop
    end

    assert_redirected_to pokestops_path
  end
end
