require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  
  test 'get new is successful' do
    get :new
    assert_response :success
  end

end
