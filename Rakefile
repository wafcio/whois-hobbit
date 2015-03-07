require_relative 'config/environment'

Dir[Whois.root.join('lib', 'tasks', '*.rake')].each { |file| import file }

spec = Gem::Specification.find_by_name 'classy_assets'
load "#{spec.gem_dir}/lib/classy_assets/tasks.rb"