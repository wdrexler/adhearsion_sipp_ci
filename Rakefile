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
    [:cps, :concurrent].each do |type|
      p "Compiling Scenario: #{type.to_s}"
      require File.expand_path("#{Adhearsion.config[:platform].root}/#{Adhearsion.config[:sipp_test][type].scenario_location}")
    end
  end

  desc "Runs a SIPp load test on both concurrent and cps-based scenarios, fails if they have too many failed calls"
  task :run => :compile do |t|
    run_test :concurrent, :cps
  end

  desc "Runs a SIPp load test meant to test concurrency, fails if there are too many failed calls"
  task :run_cc => :compile do |t|
    run_test :concurrent
  end

  desc "Runs a SIPp load test meant to test incoming call rate, fails if there are too many failed calls"
  task :run_cps => :compile do |t|
    run_test :cps
  end
end

def run_test(*scenarios)
  system "bundle exec ahn daemon --pid-file log/adhearsion.pid"
  pid = IO.read("log/adhearsion.pid").chomp.to_i
  begin
    p "Starting Adhearsion with pid #{pid}..."
    sleep 10
    Process.kill 0, pid #Make sure Adhearsion is running before we start the test

    scenarios.each do |type|
      SippTest::Runner.new(type).run
    end
  rescue => e
    p e.inspect
    Process.kill 9, pid rescue nil
    exit 1
  else
    Process.kill 9, pid rescue nil
  end
end