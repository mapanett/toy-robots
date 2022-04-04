#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require_relative '../lib/commander'

commander = Commander.new(5, $stdout)

ARGF.each do |line|
  commander.process_command(line.chomp)
end
