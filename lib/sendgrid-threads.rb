require_relative 'sendgrid_threads/config'
require_relative 'sendgrid_threads/exceptions'
require_relative 'sendgrid_threads/client'
require_relative 'sendgrid_threads/api'
require_relative 'sendgrid_threads/engine' if defined?(Rails)

module SendgridThreads
  VERSION = File.read(File.expand_path('../../VERSION', __FILE__)).strip.freeze

  def self.logger
    config.logger
  end
end
