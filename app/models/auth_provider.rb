class AuthProvider < ActiveRecord::Base
  attr_accessible :provider, :key, :secret, :env
  
  def self.current( provider )
    if table_exists?
      AuthProvider.where( provider: provider, env: Rails.env ).first
    end
  end
end
