require 'test_helper'

class PokespawnsControllerTest < ActionController::TestCase
  setup do
    @pokespawn = pokespawns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pokespawns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pokespawn" do
    assert_difference('Pokespawn.count') do
      post :create, pokespawn: { latitude: @pokespawn.latitude, longitude: @pokespawn.longitude, name: @pokespawn.name, user_id: @pokespawn.user_id }
    end

    assert_redirected_to pokespawn_path(assigns(:pokespawn))
  end

  test "should show pokespawn" do
    get :show, id: @pokespawn
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pokespawn
    assert_response :success
  end

  test "should update pokespawn" do
    patch :update, id: @pokespawn, pokespawn: { latitude: @pokespawn.latitude, longitude: @pokespawn.longitude, name: @pokespawn.name, user_id: @pokespawn.user_id }
    assert_redirected_to pokespawn_path(assigns(:pokespawn))
  end

  test "should destroy pokespawn" do
    assert_difference('Pokespawn.count', -1) do
      delete :destroy, id: @pokespawn
    end

    assert_redirected_to pokespawns_path
  end
end
