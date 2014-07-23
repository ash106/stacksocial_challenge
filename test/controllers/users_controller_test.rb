require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  test 'get index is successful' do
    session[:user_id] = users(:alex).id
    get :index
    assert_includes assigns(:users), users(:alex)
    assert_response :success
  end

  test 'get new is successful' do
    get :new
    assert_kind_of User, assigns(:user)
    assert_response :success
  end

  test 'post create is successful with valid attributes' do
    user_params = { email: 'craig@twobags.com', password: 'secret', password_confirmation: 'secret' }
    assert_difference 'User.count' do
      post :create, user: user_params
    end
    assert_redirected_to users_path
  end

  test 'post create is unsuccessful with invalid attributes' do
    invalid_params = { email: '', password: '', password_confirmation: '' }
    assert_no_difference 'User.count' do
      post :create, user: invalid_params
    end
    assert_template 'new'
    assert_response :success
  end
end
