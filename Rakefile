require 'rake/clean'
require 'socket'
require 'find'

CLEAN.include('*.class')

BASEDIR     = File.dirname(__FILE__)
SERVER_PATH = 'bin/server.rb'
TEST_NAME   = 'test.sh'

def port_closed?(port = 4567, ip = 'localhost')
  begin
    TCPSocket.new(ip, port).close
    false
  rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
    true
  end
end

task :default => 'test'

namespace :server do
  desc 'run the sinatra server without tests'
  task :start => ['server:stop'] do
    job = fork do
      exec sprintf('ruby %s/%s', BASEDIR, SERVER_PATH)
    end
    Process.detach(job)
  end

  # TODO how do we get this to execute after tests are run? .. can do forward dependencies, but not reverse.. maybe a meta task that 'server:start', 'test:all', 'server:stop'
  desc 'stop the server'
  task :stop do
    begin
      sh sprintf('killall ruby %s/%s', BASEDIR, SERVER_PATH)
    rescue RuntimeError => e
      printf('server does not appear to be running, noop')
    end
  end
end
task :server => ['server:start']

namespace :test do

  # meta task, not giving a description
  task :all do
    if port_closed?
      puts 'local server not running; run `rake server`'
      exit(2)
    end
    Find.find(sprintf('%s/test', BASEDIR)) do |file|
      next unless File.file?(file)
      next unless File.basename(file).eql?(TEST_NAME)
      begin
        sh file
      rescue => e
        sprintf('test [%s] failed with [%s], running next test', file, e.message)
      end
    end
  end

  Dir.glob(sprintf('%s/test/*', BASEDIR)).each do |top_level|
    failed = Array.new
    path = File.basename(top_level)
    desc sprintf('run [%s] specific tests', path)
    task path.to_sym do
      Dir.glob(sprintf('%s/**/%s', top_level, TEST_NAME)).each do |test|
        begin
          sh test
        rescue => e
          puts sprintf('test[%s/%s] failed[%s], going to next test', top_level, test, e.message)
          failed << sprintf('%s/%s', top_level, test)
        end

      end

      # TODO figure out how to care about overall success/failure for exit codes
      puts sprintf('failed[%s] tests[%s]', failed.size, failed) unless failed.empty?

    end
  end

end
task :test => ['test:all']