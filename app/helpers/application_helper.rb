module ApplicationHelper

  def get_bearer_token
    encoded_key = URI::encode ENV["TWITTER_KEY"]
    encoded_secret = URI::encode ENV["TWITTER_SECRET"]
    encoded_credentials = Base64.strict_encode64("#{encoded_key}:#{encoded_secret}".force_encoding('UTF-8'))

    uri = URI("https://api.twitter.com/oauth2/token")
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(uri.path)
    request["Authorization"] = "Basic #{encoded_credentials}"
    request["Content-Type"] = 'application/x-www-form-urlencoded;charset=UTF-8'
    request.body = "grant_type=client_credentials"

    response = https.request(request)

    results = JSON.parse(response.body)

    if results["token_type"] == "bearer"
      results["access_token"]
    else
      results["errors"]
    end
  end

  def tweetify(content)
    content.gsub!(/@[a-z0-9_]+/i) { |username| link_to(username, show_tweeter_path(username: username.tr('@',''))) }
    content.gsub!(/#[a-z0-9_]+/i) { |hashtag| link_to(hashtag, root_path(query: hashtag)) }
    content.gsub!(URI.regexp(['http','https'])) { |url| link_to(url, url) }
    raw(content)
  end
  
end
