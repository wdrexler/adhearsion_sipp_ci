require 'sippy_cup'

scenario = SippyCup::Scenario.new 'Concurrent', source: "127.0.0.1:8836", destination: "127.0.0.1:5060", filename: "scenarios/concurrent" do |s|
  s.invite
  s.receive_trying
  s.receive_ringing
  s.receive_progress

  s.receive_answer
  s.ack_answer

  #Sleep for the audio playback
  s.sleep Adhearsion.config[:sipp_test].concurrent.call_length

  s.send_bye
  s.receive_200
end

scenario.compile!
