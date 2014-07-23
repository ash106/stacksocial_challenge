class TweetersController < ApplicationController
  before_action :require_signin
  
  def show
    @username = params[:username]
    uri = URI("https://api.twitter.com")
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    Rails.cache.fetch("/tweeters/#{@username}", expires_in: 5.minutes) do
      request = Net::HTTP::Get.new("/1.1/statuses/user_timeline.json?screen_name=#{@username}&count=20")   
      request["Authorization"] = "Bearer #{ENV['BEARER_TOKEN']}"
      
      response = https.request(request)
    end

    @tweets = JSON.parse(response.body)
    @user_image = @tweets.first["user"]["profile_image_url_https"] unless @tweets.is_a?(Hash)
  end
end
