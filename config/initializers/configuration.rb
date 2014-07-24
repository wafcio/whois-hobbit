require 'simpleconfig'

SimpleConfig.for :application do
  load File.join(Whois.root, 'config', 'settings', 'application.rb'), if_exists?: true
  load File.join(Whois.root, 'config', 'settings', "#{Whois.env}.rb"), if_exists?: true
end

class AppConfig
  def self.method_missing(name)
    SimpleConfig.for(:application).send(name)
  end
end
