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
      greeting "Hello", :desc => "What to use to greet users"
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
