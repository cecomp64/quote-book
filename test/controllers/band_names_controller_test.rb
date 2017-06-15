require 'test_helper'

class BandNamesControllerTest < ActionController::TestCase
  setup do
    @band_name = band_names(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:band_names)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create band_name" do
    assert_difference('BandName.count') do
      post :create, band_name: { name: @band_name.name, person_id: @band_name.person_id }
    end

    assert_redirected_to band_name_path(assigns(:band_name))
  end

  test "should show band_name" do
    get :show, id: @band_name
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @band_name
    assert_response :success
  end

  test "should update band_name" do
    patch :update, id: @band_name, band_name: { name: @band_name.name, person_id: @band_name.person_id }
    assert_redirected_to band_name_path(assigns(:band_name))
  end

  test "should destroy band_name" do
    assert_difference('BandName.count', -1) do
      delete :destroy, id: @band_name
    end

    assert_redirected_to band_names_path
  end
end
