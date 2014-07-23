require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test 'has valid test data' do
    User.find_each do |user|
      assert_valid user
    end
  end

  test 'must have an email and password' do
    invalid_user = User.new
    assert_invalid invalid_user
    assert_includes invalid_user.errors[:email], "can't be blank"
    assert_includes invalid_user.errors[:password], "can't be blank"
  end

  test 'must have a unique email' do
    copy_cat = User.new(email: users(:alex).email)
    assert_invalid copy_cat, email: 'has already been taken'
  end

end
