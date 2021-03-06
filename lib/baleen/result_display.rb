require "colorize"

module Baleen
  class ResultDisplay
    def initialize(result, start_time: nil, end_time: nil)
      @result     = result
      @start_time = start_time
      @end_time   = end_time
    end

    def summary
      tests_result = pass_all? ? "Pass".green : "Fail".red
      time = run_time

      puts   ""
      notice "[Summary]"
      puts   "Result: ".yellow + tests_result
      puts   "Time: ".yellow + time.green
      puts   ""
    end

    def detail
      notice "[Details]"
      @result.each do |r|
        puts "Id: ".yellow + "#{r['container_id']}".green
        puts "status code: ".yellow + "#{r['status_code']}".green
        puts "feature file: ".yellow + "#{r['file']}".green
        puts "logs:".yellow
        puts "------------------------------------".yellow
        puts "#{r['log']}".green
      end
    end

    private

    def pass_all?
      @result.all? {|r| r[:status_code] == 0}
    end

    def run_time
      diff = @end_time - @start_time
      min  = (diff / 60).floor
      sec  = min != 0 ? (diff - (min * 60)).floor : diff.floor
      "#{min}min #{sec}sec"
    end
  end
end