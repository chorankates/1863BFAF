#!/usr/bin/env ruby
# explore_travis ... explores the travis-ci.org sudo environment in order to support our multiple language needs

failures = Array.new
context  = Hash.new

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
    raw = `which #{b}`
    context << { :type => :binary, :binary => b, :context => raw }
  rescue => e
    failures << { :type => :binary, :binary => b, :context => e.message }
  end
end
