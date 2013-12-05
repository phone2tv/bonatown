require 'test_helper'

class AccidentInsurancesControllerTest < ActionController::TestCase
  setup do
    @accident_insurance = accident_insurances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accident_insurances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create accident_insurance" do
    assert_difference('AccidentInsurance.count') do
      post :create, accident_insurance: { company_id: @accident_insurance.company_id, price: @accident_insurance.price, synopsis: @accident_insurance.synopsis, title: @accident_insurance.title }
    end

    assert_redirected_to accident_insurance_path(assigns(:accident_insurance))
  end

  test "should show accident_insurance" do
    get :show, id: @accident_insurance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @accident_insurance
    assert_response :success
  end

  test "should update accident_insurance" do
    patch :update, id: @accident_insurance, accident_insurance: { company_id: @accident_insurance.company_id, price: @accident_insurance.price, synopsis: @accident_insurance.synopsis, title: @accident_insurance.title }
    assert_redirected_to accident_insurance_path(assigns(:accident_insurance))
  end

  test "should destroy accident_insurance" do
    assert_difference('AccidentInsurance.count', -1) do
      delete :destroy, id: @accident_insurance
    end

    assert_redirected_to accident_insurances_path
  end
end
