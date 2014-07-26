SimpleConfig.for :application do
  set :sprocktes, {
    path: [
      'app/assets/images',
      'app/assets/javascripts',
      'app/assets/stylesheets',
      'app/assets/fonts'
    ],
    js_compressor: :uglify,
    css_compressor: :scss,
    manifest: 'public/assets/manifest.json',
    output: 'public/assets',
    compressed_files: %w(application.js application.css)
  }
end