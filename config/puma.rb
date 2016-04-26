require 'active_support'
require 'active_support/core_ext'

rails_root = Dir.pwd

# reference: http://qiita.com/noriaki/items/74ee4877c0989a42399b

unless ENV['RACK_ENV'] == 'production'
  environment ENV['RACK_ENV'] || 'development'
  daemonize true

  workers 2
  threads 0,2

  bind 'unix://' + File.join(rails_root, 'tmp', 'sockets', 'puma.sock')
  port 9293

  pidfile File.join(rails_root, 'tmp', 'pids', 'puma.pid')
  state_path File.join(rails_root, 'tmp', 'puma.state')

  stdout_redirect(
    File.join(rails_root, 'log', 'puma.log'),
    File.join(rails_root, 'log', 'puma-error.log'),
    true
  )

  activate_control_app('auto', auth_token: rails_root.camelize.parameterize)
end
