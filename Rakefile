#!/usr/bin/env rake

require File.expand_path('../config/environment',  __FILE__)

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
end
