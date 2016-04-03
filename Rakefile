
BASEDIR     = File.dirname(__FILE__)
SERVER_PATH = 'bin/server.rb'
TEST_NAME   = 'test.sh'

task :default => 'test'

namespace :server do
  desc 'run the sinatra server without tests'
  task :start => ['server:stop'] do
    # TODO fix this..
    #sh sprintf('ruby %s/bin/server.rb &; bg; jobs', BASEDIR)
    sh sprintf('ruby %s/%s; jobs', BASEDIR, SERVER_PATH)
  end

  # TODO how do we get this to execute after tests are run? .. can do forward dependencies, but not reverse.. maybe a meta task that 'server:start', 'test:all', 'server:stop'
  desc 'stop the server'
  task :stop do
    begin
      sh sprintf('killall ruby %s/%s', BASEDIR, SERVER_PATH)
    rescue RuntimeError => e
      #printf('server does not appear to be running, noop')
    end
  end
end
task :server => ['server:start']

namespace :test do
  desc 'run all tests, starting and stopping the server'
  task :all => ['server:start', 'test:run_all', 'server:stop']

  # meta task, not giving a description
  task :run_all do
    Dir.glob(sprintf('%s/*', BASEDIR)) do |file|
      next unless File.file?(file)
      next unless File.basename(file).eql?(TEST_NAME)
      sh file
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