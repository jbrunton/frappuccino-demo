class AuthProviders < ActiveRecord::Migration
  def up
    create_table :auth_providers do |t|
      t.string :provider
      t.string :key
      t.string :secret
      t.string :env
      
      t.timestamps
    end
    # TODO: constraints for the above...

    AuthProvider.create(
        provider: 'facebook',
        key: '378336508905387',
        secret: '640010b35299fa73c27f5a60b6253b9b',
        env: 'development' )
  end
  
  def down
    drop_table :auth_providers
  end
end