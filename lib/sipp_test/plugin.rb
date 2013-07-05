module SippTest
  class Plugin < Adhearsion::Plugin
    # Actions to perform when the plugin is loaded
    #
    init :sipp_test do
      logger.info "SippTest has been loaded"
    end

    # Basic configuration for the plugin
    #
    config :sipp_test do
      cps {
        max_failures 0, desc: "Number of failed calls before exit"
        calls_per_second 1, desc: "Number of calls per second (cps)"
        scenario_location 'scenarios/cps', desc: "Path from Adhearsion root to SippyCup template"
        max_calls 10, desc: "Maximum number of calls for the CPS scenario"
      }
      concurrent {
        max_failures 0, desc: "Number of failed calls before exit"
        max_concurrent 10, desc: "Maximum concurrency for the Concurrent scenario"
        rate 1, desc: "Ramp-up rate for the Concurrent scenario"
        scenario_location 'scenarios/concurrent', desc: "Path from Adhearsion root to SippyCup template"
        max_calls 10, desc: "Maximum number of cals for the Concurrent scenario"
      }
    end

    # Defining a Rake task is easy
    # The following can be invoked with:
    #   rake plugin_demo:info
    #
    tasks do
      namespace :sipp_test do
        desc "Prints the PluginTemplate information"
        task :info do
          STDOUT.puts "SippTest plugin v. #{VERSION}"
        end
      end
    end

  end
end
