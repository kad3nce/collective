require 'fileutils'
require 'merb/orms/data_mapper/connection'

namespace :dm do

  task :merb_start do
    Merb.start_environment :adapter => 'runner',
                           :environment => ENV['MERB_ENV'] || 'development'
  end

  namespace :db do
    desc "Create a sample database.yml file"
    task :database_yaml => :merb_start do
      sample_location = File.join(File.dirname(__FILE__), "..", "merb", "orms", "data_mapper", "database.yml.sample")
      target_location = Merb.dir_for(:config)
      FileUtils.cp sample_location, target_location
    end
    desc "Perform automigration"
    task :automigrate => :merb_start do
      ::DataMapper::AutoMigrator.auto_migrate
    end
    desc "Perform non destructive automigration"
    task :autoupgrade => :merb_start do
      ::DataMapper::AutoMigrator.auto_upgrade
    end

    namespace :migrate do
      task :load => :merb_start do
        gem 'dm-migrations'
        require 'migration_runner'
        FileList["schema/migrations/*.rb"].each do |migration|
          load migration
        end
      end

      desc "Migrate up using migrations"
      task :up, :version, :needs => :load do |t, args|
        version = args[:version] || ENV['VERSION']
        migrate_up!(version)
      end
      desc "Migrate down using migrations"
      task :down, :version, :needs => :load do |t, args|
        version = args[:version] || ENV['VERSION']
        migrate_down!(version)
      end
    end

    desc "Migrate the database to the latest version"
    task :migrate => 'dm:db:migrate:up'

    desc "Create the database (postgres only)"
    task :create do
      config = Merb::Orms::DataMapper.config
      puts "Creating database '#{config[:database]}'"
      case config[:adapter]
      when 'postgres'
        `createdb -U #{config[:username]} #{config[:database]}`
      else
        raise "Adapter #{config[:adapter]} not supported yet."
      end
    end

    desc "Drop the database (postgres only)"
    task :drop do
      config = Merb::Orms::DataMapper.config
      puts "Droping database '#{config[:database]}'"
      case config[:adapter]
      when 'postgres'
        `dropdb -U #{config[:username]} #{config[:database]}`
      else
        raise "Adapter #{config[:adapter]} not supported yet."
      end
    end

    desc "Drop the database, and migrate from scratch"
    task :reset => [:drop, :create, :migrate]
  end

  namespace :sessions do
    desc "Perform automigration for sessions"
    task :create => :merb_start do
      Merb::DataMapperSession.auto_migrate!
    end

    desc "Clears sessions"
    task :clear => :merb_start do
      table_name = ((Merb::Plugins.config[:datamapper] || {})[:session_table_name] || "sessions")
      ::DataMapper.repository.adapter.execute("DELETE FROM #{table_name}")
    end
  end
end
