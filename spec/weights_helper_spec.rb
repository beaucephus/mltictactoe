require_relative "spec_helper.rb"
require_relative "../lib/weights_helper.rb"

describe WeightsHelper do
  include WeightsHelper
  describe "#read_weights" do
    before(:all) do
      @lookup = Redis.new
      @key = "x_x___o__o_o_x_x"
      @value = [
        [52, 6, 6],
        [6, 6, 6],
        [6, 6, 6]
      ]
      @lookup.set(@key, @value.to_yaml) if @lookup.get(@key).nil?
    end

    subject do
      read_weights(@lookup, @key)
    end

    it "returns an Array of size 3" do
      expect(subject.size).to eq(3)
    end

    it "returns an Array of Arrays of size 3" do
      expect(subject.all? { |a| a.size == 3 }).to eq(true)
    end

    it "returns Integer types in arrays" do
      expect(
        subject.all? do |a|
          a.all? { |aa| aa.is_a?(Integer) }
        end
      ).to eq(true)
    end
  end
end
