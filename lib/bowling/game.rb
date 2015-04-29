module Bowling
  class Game
    def initialize(name=nil)
      @name = name
      @frames = [Frame.new(1)]
    end

    def score

    end

    def ball(score)
      raise "You can't bowl anymore" if over?
      if current_frame.can_bowl_again?
        current_frame.ball(score)
      else
        @freams << Frame.new(@frames.size + 1)
        current_frame.ball(score)
      end
    end

    def over?
      return current_frame.can_bowl_again? || frames_left?
    end
    def score_for_frame(num)
      raise "Invalid frame" unless num < 10 && num >= 0
      return :no_score unless @frames[num]
      if num == 9
        score_tenth_frame
      else
        if @frames[num].strike?
          score_strike(num)
        elsif @frames[num].spare?
          score_spare(num)
        else
          @frames[num].balls.inject(:+)
        end
      end
    end

    def current_frame
      @frames.last
    end
    private
    def frames_left?
      @frames.size < 10
    end

    def score_spare(num)
      return :no_score unless @frames[num + 1]
      return 10 + @frames[num + 1].balls.first
    end

    def strike_in_ninth_frame
      return :no_score unless @frames[9]
      next_two = @frames[9].balls[0..1]
      if next_two.size != 2
        return :no_score
      else
        return 10 + next_two.inject(:+)
      end
    end

    def score_strike(num)
      if num + 1 == 9
        return strike_in_ninth_frame
      end
      return :no_score unless @frames[num + 1] && ! @frames[num + 1].can_bowl_again?
      if @frames[num + 1].strike?
        n = @frames[num + 2]
        return n ? (20 + @frames[num + 2].balls.first) : (:no_score)
      else
        return 10 + @frames[num + 1].balls.inject(:+)
      end
    end
  end
end

