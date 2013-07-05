module SippTest
  class Watcher
    def initialize(runner, num_of_calls, polling = 3)
      @current = { time: 0, series: [[], [], []] }
      @running = false
      @polling = polling
      @runner = runner
      @num_calls = num_of_calls
    end

    def watch
      @current = DataParser.parse(path) if File.exists?(path)
      @running = true
      while @running do
        sleep @polling
        p "RUNNING WATCHER"
        data = DataParser.parse(@runner.csv_path) if File.exists?(@runner.csv_path)
        p data
        @current = data
        if @runner.status == :completed
          if (data[:series][0].last && (data[:series][1].last + data[:series][2].last) == @num_calls)
            examine_data
          else
            raise "Test failed after #{data[:time]} seconds: Expected #{num_of_calls} calls, got #{data[:series][0].last} calls"
          end
        end
      end
    end

    def examine_data
      max_failures = Adhearsion.config[:sipp_test][@type].max_failures
      raise "Test failed after #{@current[:time]} seconds: Number of failures (#{@current[:series][2]}) exceeds maximum (#{max_failures})." if @current[:series][2] > max_failures
      p "Test completed successfully in #{@current[:time]} seconds."
      p "Total Calls:      #{@current[:series][0]}"
      p "Successful Calls: #{@current[:series][1]}"
      p "Failed Calls:     #{@current[:series][2]}"
    end
  end
end