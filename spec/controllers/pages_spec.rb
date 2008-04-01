require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Pages, "index action" do
  before(:each) do
    dispatch_to(Pages, :index)
  end
end