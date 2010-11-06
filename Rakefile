# -*- ruby -*-

require 'rubygems'
require 'rake/testtask'

# vim: syntax=ruby

Rake::TestTask.new(:test) do |test|
  test.libs << 'test'
  test.test_files = FileList['test/*.rb']
  test.verbose = true
end
