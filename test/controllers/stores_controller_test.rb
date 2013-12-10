require 'test_helper'

class StoresControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get tagged" do
    get :tagged
    assert_response :success
  end

end
