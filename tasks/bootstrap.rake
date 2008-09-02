require 'bootstrapper'

desc 'Bootstrap the database ***DESTRUCTIVE***'
namespace :db do
  task :bootstrap => :merb_env do
    Bootstrapper.bootstrap!!
  end
end