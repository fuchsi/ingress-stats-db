require 'configurate'

rails_root = Pathname.new(__FILE__).dirname.join('..').expand_path
rails_env = ENV['RACK_ENV']
rails_env ||= ENV['RAILS_ENV']
rails_env ||= 'development'

config_dir = rails_root.join("config")

Config = Configurate::Settings.create do
  add_provider Configurate::Provider::Dynamic
  add_provider Configurate::Provider::Env
  add_provider Configurate::Provider::YAML, config_dir.join('settings.yml'), namespace: 'configuration'
  add_provider Configurate::Provider::YAML, config_dir.join('settings.yml'), namespace: Rails.env
end
