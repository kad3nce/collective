module Merb
  
  module Helpers
    
    @@helpers_dir   = File.dirname(__FILE__) / 'merb_helpers'
    @@helpers_files = Dir["#{@@helpers_dir}/*_helpers.rb"].collect {|h| h.match(/\/(\w+)\.rb/)[1]}
    
    def self.load
      require @@helpers_dir + '/time_dsl'
      require @@helpers_dir + '/ordinalize'
      require @@helpers_dir + '/core_ext'
       
      if Merb::Plugins.config[:merb_helpers]
        config = Merb::Plugins.config[:merb_helpers]
        raise "With and Without options have been deprecated" if config[:with] || config[:without]
        
        if config[:include] && !config[:include].empty?
          load_helpers(config[:include])
        else
          # This is in case someone defines an entry in the config,
          # but doesn't put in a with or without option
          load_helpers
        end
        
      else
        load_helpers
      end
    end
    
    # Load only specific helpers instead of loading all the helpers
    def self.load_helpers(helpers = @@helpers_files)
      helpers.each {|helper| Kernel.load(File.join(@@helpers_dir, "#{helper}.rb") )} # using load here allows specs to work
    end
    
  end
  
end

Merb::Helpers.load
