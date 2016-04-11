APP_ROOT = File.expand_path(File.dirname(File.dirname(__FILE__)))


#ENV['BUNDLE_GEMFILE'] = File.expand_path('../Gemfile', File.dirname(__FILE__))
#require 'bundler/setup'

worker_processes (ENV['RAILS_ENV'] == 'production' ? 4 : 1)
listen APP_ROOT + '/tmp/unicorn.sock', backlog: 64
listen(3999, backlog: 64) if ENV['RAILS_ENV'] == 'development'
timeout 300
working_directory APP_ROOT
pid APP_ROOT + '/tmp/unicorn.pid'
stderr_path APP_ROOT + '/log/unicorn.log'
stdout_path APP_ROOT + '/log/unicorn.log'
preload_app true

# Garbage collection settings.
GC.respond_to?(:copy_on_write_friendly=) &&
  GC.copy_on_write_friendly = true

# If using ActiveRecord, disconnect (from the database) before forking.
before_fork do |server, worker|
  f = File.open("#{server.config[:pid]}.lock", 'w')
  exit unless f.flock(File::LOCK_SH)
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!
end

# After forking, restore your ActiveRecord connection.
after_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end
