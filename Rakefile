#!/usr/bin/env rake

require File.expand_path('../config/environment',  __FILE__)
require File.expand_path('../lib/sipp_test', __FILE__)

require 'adhearsion/tasks'

task :default => :spec

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

namespace :sipp_test do
  desc "Removes old SIPp scenarios and compiles new ones"
  task :compile => :environment do |t|
    system "cd #{Adhearsion.config[:platform].root}/scenarios"
    [:cps, :concurrent].each do |type|
      require File.expand_path("#{Adhearsion.config[:platform].root}/#{Adhearsion.config[:sipp_test][type].scenario_location}")
    end
  end

  desc "Runs a SIPp load test on both concurrent and cps-based scenarios, fails if they have too many failed calls"
  task :run => :environment do |t|
    [:concurrent, :cps].each do |type|
      SippTest::Runner.new(type).run
    end
  end

  desc "Runs a SIPp load test meant to test concurrency, fails if there are too many failed calls"
  task :run_cc => :environment do |t|
    SippTest::Runner.new(:concurrent).run
  end

  desc "Runs a SIPp load test meant to test incoming call rate, fails if there are too many failed calls"
  task :run_cps => :environment do |t|
    SippTest::Runner.new(:cps).run
  end
end
