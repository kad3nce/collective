require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe User do

  describe '.new' do
    it 'should have a name property' do
      User.new(:name => 'Joe User').name.should == 'Joe User'
    end

    it 'should have an openid_url property' do
      User.new(:openid_url => 'http://identity').openid_url.should == 'http://identity'
    end

    it 'should have a trusted property' do
      User.new.trusted.should == false
    end
    
    it 'should protect the trusted property from mass assignment' do
      lambda { User.new(:trusted => true) }.should raise_error
    end
  end
  
  describe '#name' do
    it 'if blank, should be auto-populated from the openid_url' do
      @user = User.new(:openid_url => 'http://identity')
      @user.valid?
      @user.name.should == 'http://identity'
    end
  end
  
  describe '#openid_url=' do
    before(:each) do
      @user = User.new(:openid_url => 'http://identity')
      @user.valid?
      @user.stub!(:new_record?).and_return(false)
    end
    
    it 'should be immutable after the User has been created' do
      @user.openid_url = 'http://some-other-identity'
      @user.openid_url.should == 'http://identity'
    end
  end
  
  describe '#trust!' do
    before(:each) do
      @user = User.new(:name => 'Joe User')
      @user.stub!(:save)
    end
    
    it "should set a user's trusted property to true" do
      @user.trust!
      @user.trusted?.should == true
    end
    
    it 'should save the updated user' do
      @user.should_receive(:save)
      @user.trust!
    end
  end

end