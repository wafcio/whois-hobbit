require 'rake/sprocketstask'
require 'uglifier'

Rake::SprocketsTask.new do |t|
  environment = Sprockets::Environment.new
  AppConfig.sprocktes[:path].each do |path|
    environment.append_path(path)
  end
  environment.js_compressor  = AppConfig.sprocktes[:js_compressor]
  environment.css_compressor = AppConfig.sprocktes[:css_compressor]

  t.environment = environment
  t.manifest = Sprockets::Manifest.new(environment, AppConfig.sprocktes[:manifest])

  t.output = AppConfig.sprocktes[:output]
  t.assets = AppConfig.sprocktes[:compressed_files]
end