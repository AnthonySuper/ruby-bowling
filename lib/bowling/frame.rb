module Bowling
  class Frame
    def initialize(frame_num)
      @tenth = frame_num == 10
      @balls = []
    end
    attr_reader :balls
    def ball(pins)
      raise "Too many pins!" unless (0..10).include?(pins)
      raise "That's too many balls" unless can_bowl_again?
      @balls << pins
    end
    def can_bowl_again?
      (@balls.size < 2 && ! strike?) || allow_third_ball?
    end
    def strike?
      @balls.first == 10
    end

    def allow_third_ball?
      @tenth && (@balls.size < 3) && (strike? || spare?)
    end
    def spare?
      return false unless @balls.size > 1
      if @balls.first <= 9
        return (@balls[0] + @balls[1]) == 10
      end
      return false
    end
  end
end
