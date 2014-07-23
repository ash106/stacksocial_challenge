require 'test_helper'

class QueriesControllerTest < ActionController::TestCase
  test "should get index" do
    session[:user_id] = users(:alex).id
    get :index
    assert_response :success
  end

end
