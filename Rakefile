require 'find'
require 'jeweler'
require 'rake/clean'
require 'socket'

CLEAN.include('*.class')
CLOBBER.include('pkg/*')

BASEDIR      = File.dirname(__FILE__)
SERVER_PATH  = 'resources/server.rb'
TEST_NAME    = 'test.sh'
KNOWN_SERVER = '1863BFAF.pwnz.org'

Jeweler::Tasks.new do |gem|
  gem.name        = '1863BFAF'
  gem.summary     = 'validate RFC2616 (HTTP 1.1) compliance'
  gem.description = 'attempts to poke at the edges of valid HTTP responses wrt HTTP 1.1'
  gem.email       = 'conor.code@gmail.com'
  gem.homepage    = 'http://github.com/chorankates/1863BFAF'
  gem.authors     = ['Conor Horan-Kates', 'Maureen Long']
  gem.licenses    =  'MIT'

  gem.bindir = 'bin/'
end
Jeweler::RubygemsDotOrgTasks.new


def port_closed?(port = 4567, ip = KNOWN_SERVER)
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

    failed = Array.new
    Find.find(sprintf('%s/test', BASEDIR)) do |file|
      next unless File.file?(file)
      next unless File.basename(file).eql?(TEST_NAME)
      begin
        sh file
      rescue => e
        puts sprintf('test [%s] failed with [%s], running next test', file, e.message)
        failed << File.dirname(file).gsub(File.dirname(__FILE__), '').gsub('/test/', '')
      end
    end

    puts sprintf('failed[%s]%stests[%s]', failed.size, "\n", failed.join("\n")) unless failed.empty?

    Kernel.exit(failed.empty? ? 1 : 0)
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
          failed << File.dirname(test).gsub(File.dirname(__FILE__), '').gsub('test/', '')
        end

      end

      puts sprintf('failed[%s] tests[%s]', failed.size, failed.join("\n")) unless failed.empty?
    end
  end

end
task :test => ['test:all']