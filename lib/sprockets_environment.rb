require 'sprockets'

class SprocketsEnvironment
  attr_reader :environment

  def initialize
    @environment = Sprockets::Environment.new
    append_paths
  end

  def set_compressors
    environment.js_compressor  = AppConfig.sprockets[:js_compressor]
    environment.css_compressor = AppConfig.sprockets[:css_compressor]

    self
  end

  private

  def append_paths
    AppConfig.sprockets[:path].each do |path|
      environment.append_path(path)
    end
  end
end