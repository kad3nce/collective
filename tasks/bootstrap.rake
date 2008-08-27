require 'merb-core'
require 'app/models/page'
require 'app/models/version'

desc 'Bootstrap the database. *** DESTRUCTIVE ***'
namespace :db do
  task :bootstrap do
    Version.auto_migrate!    
    Page.auto_migrate! 
    @page = Page.create!(:name => 'Home')
    @page.versions << Version.new(:content => '[[First Page]]')
    @page.save
  end
end