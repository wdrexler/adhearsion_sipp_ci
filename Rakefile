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
    begin
      system "bundle exec ahn daemon --pid-file log/adhearsion.pid"
      pid = `cat log/adhearsion.pid`.chomp
      p "Starting Adhearsion with pid #{pid}..."
      sleep 10
    
      [:concurrent, :cps].each do |type|
        SippTest::Runner.new(type).run
      end
    rescue => e
      p e.inspect
      `kill #{pid}`
      exit 1
    else
      `kill #{pid}`
    end
  end

  desc "Runs a SIPp load test meant to test concurrency, fails if there are too many failed calls"
  task :run_cc => :environment do |t|
    begin
      system "bundle exec ahn daemon --pid-file log/adhearsion.pid"
      pid = `cat log/adhearsion.pid`.chomp
      p "Starting Adhearsion with pid #{pid}..."
      sleep 10
    
      SippTest::Runner.new(:concurrent).run
    rescue => e
      p e.inspect
      `kill #{pid}`
      exit 1
    else
      `kill #{pid}`
    end
  end

  desc "Runs a SIPp load test meant to test incoming call rate, fails if there are too many failed calls"
  task :run_cps => :environment do |t|
    begin
      system "bundle exec ahn daemon --pid-file log/adhearsion.pid"
      pid = `cat log/adhearsion.pid`.chomp
      p "Starting Adhearsion with pid #{pid}..."
      sleep 10

      SippTest::Runner.new(:cps).run
    rescue => e
      p e.inspect
      `kill #{pid}`
      exit 1
    else
      `kill #{pid}`
    end
  end
end
