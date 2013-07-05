require 'spec_helper'
describe CPSController do
  let(:call) { mock :mock_call }
  subject { CPSController.new call, {} }
  describe "#run" do
    it 'should answer, play a sound file, and hangup' do
      subject.should_receive :answer
      subject.should_receive(:play).with 'tt-weasels'
      subject.should_receive :hangup
      subject.run
    end
  end
end