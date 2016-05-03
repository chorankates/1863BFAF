#!/usr/bin/env ruby
# explore_travis ... explores the travis-ci.org sudo environment in order to support our multiple language needs
require 'pp'

failures = Array.new
context  = Array.new

binary = [
  'java',
  'perl',
  'php',
  'python',
  'ruby',
  'curl',
  'wget',
]

binary.each do |b|
  begin
    which   = `which #{b}`
    version = `#{sprintf('%s -v', b)}`
    context << { :type => :binary, :binary => b, :context => { :which => which, :version => version } }
  rescue => e
    failures << { :type => :binary, :binary => b, :context => e.message }
  end
end

pp sprintf('context[%s]', context)
pp sprintf('failures[%s]', failures)

