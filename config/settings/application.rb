SimpleConfig.for :application do
  set :sprockets, {
    path: [
      'app/assets',
      'vendor/assets/bower_components',
      'vendor/assets/bower_components/bootstrap/dist',
      'vendor/assets/bower_components/font-awesome'
    ],
    js_compressor: :uglify,
    css_compressor: :scss,
    manifest: 'public/assets/manifest.json',
    output: 'public/assets',
    compressed_files: %w(application.js application.css)
  }
end