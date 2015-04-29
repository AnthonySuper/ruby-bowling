require 'spec_helper'

RSpec.describe Bowling::Frame do
	it "doesn't allow more than 10 pins to be knocked over in one ball" do
		f = Bowling::Frame.new(1)
		expect{
			f.ball(1100)
		}.to raise_error
	end
  context "in frame 10" do
    let(:f){Bowling::Frame.new(10)}
    describe "getting to bowl a third time" do
      it "happens when you get a strike" do
        expect{
          f.ball(10)
          f.ball(6)
          f.ball(4)
        }.to_not raise_error
      end
      it "happens when you get a spare" do
        expect{
          f.ball(0)
          f.ball(10)
          f.ball(4)
        }.to_not raise_error
      end
      it "doesn't happen otherwise" do
        expect{
          f.ball(0)
          f.ball(0)
          f.ball(10)
        }.to raise_error
      end
    end
  end
	context "in frames 1-9" do
		let(:f){Bowling::Frame.new(1)}
		it "allows us to add 2 scores" do
			expect{
				f.ball(3)
				f.ball(0)
			}.to_not raise_error
			expect{
				f.ball(3)
			}.to raise_error
		end
		it "properly calculates a strike" do
			f.ball(10)
			expect(f.strike?).to eq(true)
		end
		it "properly calcultes a spare" do
			f.ball(4)
			f.ball(6)
			expect(f.spare?).to eq(true)
		end
	end
end
