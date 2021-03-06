require "json"
require "baleen/task/base"

module Baleen
  module Task
    module Request

      class Cucumber < Base

        attr_reader :target_files

        def initialize(opt)
          super()
          @params[:shell]          = opt[:shell]       ||="/bin/bash"
          @params[:opt]            = opt[:opt]         ||="-c"
          @params[:work_dir]       = opt[:work_dir]    ||="./"
          @params[:files]          = opt[:files]       ||="features"
          @params[:exe]            = opt[:exe]         ||="bundle exec cucumber"
          @params[:concurrency]    = opt[:concurrency] ||=2
          @params[:image]          = opt[:image]
          @params[:before_command] = opt[:before_command]
          @params[:command]        = opt[:command]
          @params[:results]        = opt[:results]
          @params[:status]         = opt[:status]
        end

        def prepare
          task = self.dup
          task.command = %{find #{task.files} | grep "\\.feature"}
          runner = Baleen::Runner.new(task)
          runner.run
          @target_files = runner.status[:log].split("\n")
        end

      end

    end
  end
end