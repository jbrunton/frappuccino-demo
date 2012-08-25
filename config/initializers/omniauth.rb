Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '378336508905387', '640010b35299fa73c27f5a60b6253b9b'
end