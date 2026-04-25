OmniAuth.config.allowed_request_methods = [:post, :get]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :yahoojp, ENV['YAHOOJP_KEY'], ENV['YAHOOJP_SECRET'],
  {
    :scope => 'openid profile email address',
    :userinfo_access => ENV.fetch('YAHOOJP_USERINFO_ACCESS', 'true') != 'false'
  }
end
