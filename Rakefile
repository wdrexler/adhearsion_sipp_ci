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
      require File.expand_path("#{Adhearsion.config[:platform].root}/#{Adhearsion.config[:sipp_test][type].scenario_location}")
    end
  end

  desc "Runs a SIPp load test on both concurrent and cps-based scenarios, fails if they have too many failed calls"
  task :run => :environment do |t|
    system "bundle exec ahn daemon --pid-file log/adhearsion.pid"
    pid = `cat log/adhearsion.pid`.chomp
    p "Starting Adhearsion with pid #{pid}..."
    sleep 10
    begin
      [:concurrent, :cps].each do |type|
        SippTest::Runner.new(type).run
      end
    ensure
      `kill #{pid}`
    end
  end

  desc "Runs a SIPp load test meant to test concurrency, fails if there are too many failed calls"
  task :run_cc => :environment do |t|
    system "bundle exec ahn daemon --pid-file log/adhearsion.pid"
    pid = `cat log/adhearsion.pid`.chomp
    p "Starting Adhearsion with pid #{pid}..."
    sleep 10
    begin
      SippTest::Runner.new(:concurrent).run
    ensure
      `kill #{pid}`
    end
  end

  desc "Runs a SIPp load test meant to test incoming call rate, fails if there are too many failed calls"
  task :run_cps => :environment do |t|
    system "bundle exec ahn daemon --pid-file log/adhearsion.pid"
    pid = `cat log/adhearsion.pid`.chomp
    p "Starting Adhearsion with pid #{pid}..."
    sleep 10
    begin
      SippTest::Runner.new(:cps).run
    ensure
      `kill #{pid}`
    end
  end
end
