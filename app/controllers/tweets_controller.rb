class TweetsController < ApplicationController
  before_action :require_signin

  def index
    uri = URI("https://api.twitter.com")
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    @query = if params[:query]
      Query.create!(content: params[:query])
      URI::encode(params[:query])
    else
      URI::encode(['stacksocial', 'ruby on rails', 'tenderlove', 'railscasts'].sample)
    end

    request = Net::HTTP::Get.new("/1.1/search/tweets.json?q=#{@query}&count=20&result_type=recent")   
    request["Authorization"] = "Bearer #{ENV['BEARER_TOKEN']}"
    
    response = https.request(request)

    @tweets = JSON.parse(response.body)["statuses"]

    @query = URI::decode(@query)
  end

end
