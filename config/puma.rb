require 'active_support'
require 'active_support/core_ext'

rails_root = Dir.pwd

environment Rails.env

workers 2
threads 0,16

pidfile File.join(rails_root, 'tmp', 'pids', 'puma.pid')
state_path File.join(rails_root, 'tmp', 'puma.state')

stdout_redirect(
  File.join(rails_root, 'log', 'puma.log'),
  File.join(rails_root, 'log', 'puma-error.log'),
  true
)
