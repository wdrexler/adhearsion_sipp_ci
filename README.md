# adhearsion_sipp_ci

This application runs SIPp loadtests through a rake task, and is suitable for load testing through CI.

## Getting Started

The following steps will run a SIPp load test of Adhearsion:

1. Get Asterisk
2. Configure Asterisk to accept calls from sipp@localhost
3. [Configure Asterisk for use with Adhearsion](http://adhearsion.com/docs/getting-started/asterisk)
4. Clone this repository
5. Place any necessary configuration in `config/adhearsion.rb`
6. `bundle exec rake sipp_test:compile`
7. `bundle exec rake sipp_test:run`

Then wait for your results.  Unless any controllers and/or SippyCup scenario files have been changed, only step 7 needs to be repeated for any future testing.

## Changing controllers and scenarios

Controllers for `concurrent` and `cps` scenarios are Adhearsion CallControllers, and may be changed as such.  

The scenarios (Ruby scripts in the `scenarios/` directory) use the [SippyCup](https://github.com/bklang/sippy_cup) library.  These scripts may be changed to reflect any changes made to the controllers. Once changes have been made, run `bundle exec rake sipp_test:compile` to generate the necessary XML and PCAP files.

## Configuration Options

The `sipp_test` Adhearsion plugin adds some new configuration options that help define the nature of each test. The configuration options supplied are:

### config.sipp_test
<dl>
  <dt>config.sipp_test.from_ip</dt>
  <dd>The IP address from which to send calls (binds to an interface, default "127.0.0.1") [AHN_SIPP_TEST_FROM_IP]</dd>
  <dt>config.sipp_test.to_ip</dt>
  <dd>The IP address to which to send calls (default "127.0.0.1") [AHN_SIPP_TEST_TO_IP]</dd>
</dl>

### config.sipp_test.concurrent
<dl>
  <dt>config.sipp_test.concurrent.call_length</dt>
  <dd>Length in seconds of calls for the Concurrent scenario [AHN_SIPP_TEST_CONCURRENT_CALL_LENGTH]</dd>

  <dt>config.sipp_test.concurrent.max_calls</dt>
  <dd>Maximum number of calls for the Concurrent scenario [AHN_SIPP_TEST_CONCURRENT_MAX_CALLS]</dd>

  <dt>config.sipp_test.concurrent.max_concurrent</dt>
  <dd>Maximum concurrency for the Concurrent scenario [AHN_SIPP_TEST_CONCURRENT_MAX_CONCURRENT]</dd>
    
  <dt>config.sipp_test.concurrent.max_failures</dt>
  <dd>Number of failed calls before exit [AHN_SIPP_TEST_CONCURRENT_MAX_FAILURES]</dd>

  <dt>config.sipp_test.concurrent.rate</dt>
  <dd>Ramp-up rate for the Concurrent scenario [AHN_SIPP_TEST_CONCURRENT_RATE]</dd>

  <dt>config.sipp_test.concurrent.scenario_location</dt>
  <dd>Path from Adhearsion root to SippyCup template [AHN_SIPP_TEST_CONCURRENT_SCENARIO_LOCATION]</dd>
</dl>

### config.sipp_test.cps
<dl>
  <dt>config.sipp_test.cps.calls_per_second</dt>
  <dd>Number of calls per second (cps) [AHN_SIPP_TEST_CPS_CALLS_PER_SECOND]</dd>
  
  <dt>config.sipp_test.cps.max_calls</dt>
  <dd>Maximum number of calls for the CPS scenario [AHN_SIPP_TEST_CPS_MAX_CALLS]</dd>
  
  <dt>config.sipp_test.cps.max_failures</dt>
  <dd>Number of failed calls before exit [AHN_SIPP_TEST_CPS_MAX_FAILURES]</dd>
  
  <dt>config.sipp_test.cps.scenario_location</dt>
  <dd>Path from Adhearsion root to SippyCup template [AHN_SIPP_TEST_CPS_SCENARIO_LOCATION]</dd>
</dl>

These configuration options may be specified either via `config/adhearsion.rb` or via environment variables. The defaults for these variables may be seen by running `bundle exec rake config:show`.  All available rake tasks can be seen by running `bundle exec rake -T`