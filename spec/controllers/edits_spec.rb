require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Spams, "index action" do
  before(:each) do
    dispatch_to(Spams, :index)
  end
end