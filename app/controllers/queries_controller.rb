class QueriesController < ApplicationController
  def index
    @queries = Query.order(created_at: :desc)
  end
end
