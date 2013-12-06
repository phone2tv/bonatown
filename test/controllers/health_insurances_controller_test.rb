require 'test_helper'

class HealthInsurancesControllerTest < ActionController::TestCase
  setup do
    @health_insurance = health_insurances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:health_insurances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create health_insurance" do
    assert_difference('HealthInsurance.count') do
      post :create, health_insurance: { body: @health_insurance.body }
    end

    assert_redirected_to health_insurance_path(assigns(:health_insurance))
  end

  test "should show health_insurance" do
    get :show, id: @health_insurance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @health_insurance
    assert_response :success
  end

  test "should update health_insurance" do
    patch :update, id: @health_insurance, health_insurance: { body: @health_insurance.body }
    assert_redirected_to health_insurance_path(assigns(:health_insurance))
  end

  test "should destroy health_insurance" do
    assert_difference('HealthInsurance.count', -1) do
      delete :destroy, id: @health_insurance
    end

    assert_redirected_to health_insurances_path
  end
end
