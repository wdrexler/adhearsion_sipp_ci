#encoding: utf-8

class CPSController < Adhearsion::CallController
  def run
    answer
    play 'tt-weasels'
    hangup
  end
end