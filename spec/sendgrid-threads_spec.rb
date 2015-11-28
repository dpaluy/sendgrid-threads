require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "SendgridThreads" do
  it "has a version" do
    expect(SendgridThreads::VERSION).not_to be_nil
  end
end
