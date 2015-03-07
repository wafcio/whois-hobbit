require 'sass'
require 'uglifier'
require 'classy_assets'

ClassyAssets.config do |config|
  config.asset_root = Whois.root
  config.asset_paths = ['app/assets/stylesheets']
  config.css_compressor = :scss
end
