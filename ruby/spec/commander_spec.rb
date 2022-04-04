# frozen_string_literal: true

require_relative '../lib/commander'
require_relative '../lib/position'

RSpec.describe Commander do
  let(:string_writer) { StringIO.new }
  let(:commander) { Commander.new 5, string_writer }

  it 'creates a unplaced robot' do
    expect(commander.robot.position).to be_nil
  end

  it 'commands before a place have no effect' do
    %w[left move right move].each do |command|
      commander.process_command(command)
    end

    expect(commander.robot.position).to be_nil
  end

  it 'can place the robot' do
    commander.process_command('place 1,1,north')

    expect(commander.robot.position).to eq(Position.new(1, 1))
    expect(commander.robot.direction).to eq(:north)
  end

  it 'can place, move and turn the robot' do
    ['place 1,1,north', 'LEFT', 'move'].each do |command|
      commander.process_command(command)
    end

    expect(commander.robot.position).to eq(Position.new(0, 1))
    expect(commander.robot.direction).to eq(:west)
  end

  it 'can report on the robots position' do
    commander.process_command('place 1,1,north')
    commander.process_command('report')

    expect(string_writer.string).to eq("1,1,NORTH\n")
  end
end
