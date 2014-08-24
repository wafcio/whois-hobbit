require 'rake/sprocketstask'
require 'uglifier'

Rake::SprocketsTask.new do |t|
  t.environment = SprocketsEnvironment.new.set_compressors.environment
  t.manifest = Sprockets::Manifest.new(t.environment, AppConfig.sprockets[:manifest])

  t.output = AppConfig.sprockets[:output]
  t.assets = AppConfig.sprockets[:compressed_files]
end