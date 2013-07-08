module SippTest
  class Runner
    attr_accessor :status
    attr_reader :csv_path
    def initialize(type)
      @type = type
      raise ArgumentError("Type #{@type} not supported!") unless @type == :concurrent || @type == :cps
      @scenario_path = "#{Adhearsion.config[:platform].root}/#{Adhearsion.config[:sipp_test][@type].scenario_location}.xml"
      @csv_path = "#{Adhearsion.config[:platform].root}/results/#{Time.new.strftime("%Y%m%d%H%M%S")}-#{@type}.csv"
      @extension = get_extension @type
      self.status = :new
    end

    def run
      case @type
      when :concurrent
        run_concurrent
      when :cps
        run_cps
      end
    end

    def run_concurrent
      self.status = :running
      cc_config = Adhearsion.config[:sipp_test].concurrent
      command = "sudo sipp -i 127.0.0.1 -p 8836 -sf #{@scenario_path} -r #{cc_config.rate} -l #{cc_config.max_concurrent} "
      command << "-m #{cc_config.max_calls} -s #{@extension} 127.0.0.1 "
      command << "-trace_stat -stf #{@csv_path} > /dev/null 2>&1"
      p "RUNNING COMMAND:\n #{command}"
      start_watcher
      system command
      self.status = :completed
    end

    def run_cps
      self.status = :running
      cps_config = Adhearsion.config[:sipp_test].cps
      command = "sudo sipp -i 127.0.0.1 -p 8836 -sf #{@scenario_path} -r #{cps_config.calls_per_second} "
      command << "-l #{cps_config.max_calls} -m #{cps_config.max_calls} -s #{@extension} 127.0.0.1 "
      command << "-trace_stat -stf #{@csv_path} > /dev/null 2>&1"
      p "RUNNING COMMAND:\n #{command}"
      start_watcher
      system command
      self.status = :completed
    end

    def get_extension(type)
      return case type
      when :concurrent
        "1"
      when :cps
        "2"
      end
    end

    def start_watcher
      w = SippTest::Watcher.new self, Adhearsion.config[:sipp_test][@type].max_calls, Adhearsion.config[:sipp_test].poll_rate
      w.watch
    end
  end
end
