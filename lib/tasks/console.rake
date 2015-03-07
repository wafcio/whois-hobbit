desc 'Start a console'
task :console do
  require 'pry'

  ARGV.clear
  Pry.start
end
