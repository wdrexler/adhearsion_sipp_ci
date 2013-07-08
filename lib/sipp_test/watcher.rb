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
      @current = DataParser.parse(@runner.csv_path) if File.exists?(@runner.csv_path)
      @running = true
      while @running do
        sleep @polling
        data = DataParser.parse(@runner.csv_path) if File.exists?(@runner.csv_path)
        @current = data
        next unless data
        if (data[:series][0].last && (data[:series][1].last + data[:series][2].last) == @num_calls)
          examine_data
          @running = false
        end
      end
    end

    def examine_data
      max_failures = Adhearsion.config[:sipp_test][@runner.type].max_failures
      raise "Test failed after #{@current[:time].last}: Number of failures (#{@current[:series][2].last}) exceeds maximum (#{max_failures})." if @current[:series][2].last > max_failures
      p "Test completed successfully in #{@current[:time].last} seconds."
      p "Total Calls:      #{@current[:series][0].last}"
      p "Successful Calls: #{@current[:series][1].last}"
      p "Failed Calls:     #{@current[:series][2].last}"
    end
  end
end