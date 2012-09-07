Rails.application.config.middleware.use OmniAuth::Builder do
    facebook_provider = AuthProvider.current(:facebook) 
    if facebook_provider
        provider :facebook, facebook_provider.key, facebook_provider.secret
    end
end