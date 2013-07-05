module SippTest
  class Runner
    attr_accessor :status
    def initialize(type)
      @type = type
      raise ArgumentError("Type #{@type} not supported!") unless @type == :concurrent || @type == :cps
      @scenario_path = "#{Adhearsion.config[:platform].root}/#{Adhearsion.config[:sipp_test][@type].scenario_location}.xml"
      @csv_path = "#{Adhearsion.config[:platform].root}/scenarios/#{Time.new.strftime("%Y%m%d%H%M%S")}-#{@type}.csv"
      @extension = get_extension @type
      self.status = :stopped
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
    end

    def run_cps
    end

    def get_extension(type)
    end
  end
end
