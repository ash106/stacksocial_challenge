require 'test_helper'

class QueryTest < ActiveSupport::TestCase

  test 'has valid test data' do
    Query.find_each do |query|
      assert_valid query
    end
  end

  test 'must have content' do
    invalid_query = Query.new
    assert_invalid invalid_query
    assert_includes invalid_query.errors[:content], "can't be blank"
  end

end
