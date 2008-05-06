desc 'Bootstrap the database. *** DESTRUCTIVE ***'
namespace :db do
  task :bootstrap do
    DataMapper::Persistence.auto_migrate!
    Page.create!(:name => 'Home', :content => '[[First Page]]')
  end
end