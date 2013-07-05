#encoding: utf-8

class ConcurrentController < Adhearsion::CallController
  def run
    loop do
      play 'tt-monkeys'
    end
  end
end