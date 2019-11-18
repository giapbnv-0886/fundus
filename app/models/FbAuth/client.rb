class FacebookClient
  attr_accessor :id, :secret

  SITE = "https://graph.facebook.com/v5.0"
  AUTHORIZE_URL = "https://www.facebook.com/v5.0/dialog/oauth"
  TOKEN_PATH = "/oauth/access_token"

  def initialize id, secret
    self.id = id
    self.secret = secret
  end

  def get_token_from code, redirect_uri
    res = RestClient.get URI.encode("https://graph.facebook.com/v5.0/oauth/access_token?client_id=#{ENV["APP_ID"]}&redirect_uri=#{URI.encode(redirect_uri)}&client_secret=#{ENV["APP_SECRET"]}&code=#{code}")
    access_token_hash = JSON.parse res.body
  rescue
    return
  end

  def check_token access_token
    return unless access_token
    res = RestClient.get "https://graph.facebook.com/debug_token?input_token=#{access_token}&access_token=2412135862173156|9182f48cb1db27ce84ab23334bc56a72"
    hash_checked_token = JSON.parse res.body
  rescue
    return
  end

  def is_valid? access_token
    hash_checked_token = check_token access_token
    if hash_checked_token
      return hash_checked_token["data"]["is_valid"]
    end
    hash_checked_token
  end

  def get_info_from access_token, fields
    return unless is_valid?(access_token)
    res = RestClient.get "#{SITE}/me?fields=#{fields.join(",")}&access_token=#{access_token}"
    me_info = JSON.parse res.body
  rescue
    return
  end

  class << self
    def parse_info_from raw_info
      return unless raw_info
      info = {
          "id": raw_info["id"],
          "uid": raw_info["id"],
          "info": {
              "username": raw_info["username"],
              "email": raw_info["email"],
              "name": raw_info["name"],
              "first_name": raw_info["first_name"],
              "last_name": raw_info["last_name"],
              "gender": raw_info["gender"],
              "image": raw_info["picture"]["data"]["url"],
              "urls": {
                  "Facebook": raw_info["link"],
                  "Website": raw_info["website"]
              }
          },
          "provider": "facebook"
      }
    end
  end
end
