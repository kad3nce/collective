require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Sessions do
  describe 'requesting /sessions with POST' do
    def do_post
      dispatch_to(Sessions, :create) do |controller|
        controller.stub!(:openid_request?).and_return(true)
        controller.stub!(:set_user)
        yield(controller) if block_given?
      end
    end
    
    before(:each) do
      @user = User.new
      @user.stub!(:id).and_return(1)
      User.stub!(:first).and_return(@user)
      User.stub!(:create).and_return(@user)
    end
    
    it 'should authenticate with open id if openid params are present' do
      do_post do |controller|
        controller.should_receive(:openid_authenticate)
      end
    end
    
    describe 'if openid authentication succeeds' do
      it 'should populate @user by fetching an existing user from the database' do
        User.should_receive(:first).and_return(@user)
        User.should_not_receive(:create)
        do_post do |controller|
          controller.should_receive(:openid_authenticate).and_yield(:successful, 'http://identity', { 'fullname' => 'Wiki User' })
        end.assigns(:user).should == @user
      end
      
      it 'should populate @user by creating a new user if necessary' do
        User.should_receive(:first).and_return(nil)
        User.should_receive(:create).and_return(@user)
        controller = do_post do |controller|
          controller.should_receive(:openid_authenticate).and_yield(:successful, 'http://identity', { 'fullname' => 'Wiki User' })
        end
        controller.assigns(:user).should == @user
        controller.session[:user_id].should == 1
      end
    end
    
    describe 'if openid authentication fails' do
      it 'should render new' do
        do_post do |controller|
          controller.should_receive(:openid_authenticate).and_yield(:failed, nil, nil)
          controller.should_receive(:render).with(:new)
        end
      end
    end
    
    it 'should redirect if open id params are not present' do
      do_post do |controller|
        controller.should_receive(:openid_request?).and_return(false)
      end.should be_redirection
    end
  end

  describe 'requesting /sessions with DELETE' do
    def do_delete
      dispatch_to(Sessions, :create) do |controller|
        yield(controller) if block_given?
      end
    end
    
    # TODO: figure out how to set up the session
    it 'should set session[:user_id] to nil' do
      do_delete.session[:user_id].should == nil
    end
    
    it 'should redirect' do
      do_delete.should be_redirection
    end
  end
end