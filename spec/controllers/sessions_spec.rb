require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Sessions, "index action" do
  before(:each) do
    dispatch_to(Sessions, :index)
  end
end