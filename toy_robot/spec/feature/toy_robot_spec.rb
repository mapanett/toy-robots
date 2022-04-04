require 'rspec'
require 'open3'


describe 'toy_robot' do
  CMD = File.join(File.dirname(__FILE__), '..', '..', 'bin', 'toy_robot.rb')

  [
      {
          input: "PLACE 0,0,NORTH\nMOVE\nREPORT",
          expected: "0,1,NORTH\n"
      },
      {
          input: "PLACE 0,0,NORTH\nLEFT\nREPORT",
          expected: "0,0,WEST\n"
      },
      {
          input: "PLACE 1,2,EAST\nMOVE\nMOVE\nLEFT\nMOVE\nREPORT",
          expected: "3,3,NORTH\n"
      }
  ].each_with_index do |example, index|
    it "works like this example ##{index}" do
      output = nil
      Open3.popen3(CMD) { |stdin, stdout, stderr, wait_thr|
        stdin.write(example[:input])
        stdin.close

        output = stdout.read
        wait_thr.value
      }

      expect(output).to eq(example[:expected])
    end
  end
end