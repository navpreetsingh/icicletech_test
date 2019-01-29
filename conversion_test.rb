require "minitest/autorun"
require "./conversion"

describe Conversion do
    before do
        @number = [6686787825, 2282668687, 9876543245]
        @result = [
            [["motor", "usual"], ["noun", "struck"], ["nouns", "truck"], ["nouns", "usual"], ["onto", "struck"], ["motortruck"]],
            [["act", "amounts"], ["act", "contour"], ["acta", "mounts"], ["bat", "amounts"], ["bat", "contour"], ["cat", "contour"], ["catamounts"]]
        ] 
    end

    describe "when passed a valid number" do
        it "should convert the first number to readable words" do
            @conversion = Conversion.new @number[0]
            conversion_result = @conversion.result
            @result[0].each do |result|
                conversion_result.must_include result
            end
        end

        it "should convert the second number to readable words" do
            @conversion = Conversion.new @number[1]
            conversion_result = @conversion.result
            @result[1].each do |result|
                conversion_result.must_include result
            end
        end

        it "should give nil to third numbers" do
            @conversion = Conversion.new @number[2]
            conversion_result = @conversion.result
            conversion_result.must_be_nil
        end

        it "should give nil to invalid numbers" do
            @conversion = Conversion.new 123465
            conversion_result = @conversion.result
            conversion_result.must_be_nil
        end
    end
end