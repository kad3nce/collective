class Bootstrapper
  # This will destroy everything in the database. Use extreme caution!
  def self.bootstrap!
    repository.auto_migrate!    
    page = Page.create(:name => 'Home')
    user = User.create(:name => 'Anonymous', :openid_url => 'http://wiki.merbivore.com')
    Version.create(:content => '[[First Page]]', :user => user, :page => page)
  end
end