require 'csv'
module SippTest
  class DataParser
    class << self
      def parse(path)
        elapsed = []
        total = []
        success = []
        failed = []
        step = 0
        if File.exists?(path)
          CSV.foreach(path, :headers => true, :col_sep => ";") do |row|
            total_step = row["TotalCallCreated"].to_i
            success_step = row["SuccessfulCall(C)"].to_i
            failed_step = row["FailedCall(C)"].to_i
            elapsed << [step, row["ElapsedTime(C)"]]
            total << [step, total_step]
            success << [step, success_step]
            failed << [step, failed_step]
            step += 1
          end
        end
        {time: elapsed, series: [total, success, failed]}
      end
    end
  end
end