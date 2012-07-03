require 'spec_helper'

describe "Timl" do
  it "should pass all examples cases in spec/case" do
    Timl::TESTPAIRS.each do |pair|
      test_case, result = pair

      # Check that the eval'd test case is the same as the result content for
      # each test pair. A test pair is a pair of numbered files from the
      # spec/case and spec/result directories.
      #
      # The last File.read(result) has a .chomp because the File.read adds a
      # newline to the end of a file for some reason.
      eval(File.read(test_case)).should == File.read(result).chomp
    end
  end
end
