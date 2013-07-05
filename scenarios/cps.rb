require 'sippy_cup'

scenario = SippyCup::Scenario.new 'CPS', source: "127.0.0.1:8836", destination: "127.0.0.1:5060"  do |s|
  s.invite
  s.receive_trying
  s.receive_ringing
  s.receive_progress

  s.receive_answer
  s.ack_answer

  #Sleep for the audio playback
  s.sleep 2

  s.receive_bye
  s.ack_bye
end

scenario.compile!