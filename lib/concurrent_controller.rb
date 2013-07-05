#encoding: utf-8

class ConcurrentController < Adhearsion::CallController
  def run
    answer
    loop do
      play 'tt-monkeys'
    end
  end
end