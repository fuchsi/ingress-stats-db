# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Load configuration system early
require Rails.root.join('config', 'load_config')

# Initialize the Rails application.
Rails.application.initialize!
