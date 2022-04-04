#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'commander'

commander = Commander.new(5)

ARGF.each do |line|
  result = commander.process_command(line.chomp)
  puts result unless result.nil?
end