require 'spec_helper'

RSpec.describe Bowling::Game do
  describe "initialization" do
    it "optionally allows a name to be set" do
      expect{
        Bowling::Game.new("Bobby")
      }.to_not raise_error
    end
    it "doesn't require a name to be set" do
      expect{
        Bowling::Game.new
      }.to_not raise_error
    end
  end
  describe "playing" do
    let(:g){Bowling::Game.new("Bobby")}
    it "doesn't let you get more than 13 strikes" do
      expect{
        13.times do
          g.ball(10)
        end
      }.to raise_error
    end

    it "does let you bowl a perfect game" do
      12.times do 
        g.ball(10)
      end
      expect(g.score).to eq(300)
    end
    it "knows when the game is over" do
      12.times do
        g.ball(10)
      end
      expect(g.over?).to eq(true)
    end
  end  
end
