Rails.application.config.middleware.use OmniAuth::Builder do
    if Rails.env == "production"
        provider :facebook, '440801059299022', '6252372745f2d2e6d0c58b8ed9c1709f'
    else
        provider :facebook, '378336508905387', '640010b35299fa73c27f5a60b6253b9b'
    end
end