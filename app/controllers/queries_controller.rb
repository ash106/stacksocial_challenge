class QueriesController < ApplicationController
  before_action :require_signin
  
  def index
    @queries = Query.order(created_at: :desc)
  end
end
