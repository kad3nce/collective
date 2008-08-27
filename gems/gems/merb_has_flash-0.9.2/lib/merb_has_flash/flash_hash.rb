module MerbHasFlash
  class FlashNow #:nodoc:
    def initialize(flash)
      @flash = flash
    end
    
    def []=(k, v)
      @flash[k] = v
      @flash.discard(k)
      v
    end
    
    def [](k)
      @flash[k]
    end
  end
  
  class FlashHash < Hash
    def initialize #:nodoc:
      super
      @used = {}
    end
    
    def []=(k, v) #:nodoc:
      keep(k)
      super
    end
    
    def update(h) #:nodoc:
      h.keys.each{ |k| discard(k) }
      super
    end
    
    alias :merge! :update
    
    def replace(h) #:nodoc:
      @used = {}
      super
    end
  
    # Sets a flash that will not be available to the next action, only to the current.
    #
    #     flash.now[:message] = "Hello current action"
    # 
    # This method enables you to use the flash as a central messaging system in your app.
    # When you need to pass an object to the next action, you use the standard flash assign (<tt>[]=</tt>).
    # When you need to pass an object to the current action, you use <tt>now</tt>, and your object will
    # vanish when the current action is done.
    #
    # Entries set via <tt>now</tt> are accessed the same way as standard entries: <tt>flash['my-key']</tt>.
    def now
      FlashNow.new self
    end
  
    # Keeps either the entire current flash or a specific flash entry available for the next action:
    #
    #    flash.keep            # keeps the entire flash
    #    flash.keep(:notice)   # keeps only the "notice" entry, the rest of the flash is discarded
    def keep(k = nil)
      use(k, false)
    end
  
    # Marks the entire flash or a single flash entry to be discarded by the end of the current action
    #
    #     flash.keep                 # keep entire flash available for the next action
    #     flash.discard(:warning)    # discard the "warning" entry (it'll still be available for the current action)
    def discard(k = nil)
      use(k)
    end
  
    # Mark for removal entries that were kept, and delete unkept ones.
    #
    # This method is called automatically by filters, so you generally don't need to care about it.
    def sweep #:nodoc:
      keys.each do |k| 
        unless @used[k]
          use(k)
        else
          delete(k)
          @used.delete(k)
        end
      end

      (@used.keys - keys).each{|k| @used.delete k } # clean up after keys that could have been left over by calling reject! or shift on the flash
    end
  
    private
      # Used internally by the <tt>keep</tt> and <tt>discard</tt> methods
      #     use()               # marks the entire flash as used
      #     use('msg')          # marks the "msg" entry as used
      #     use(nil, false)     # marks the entire flash as unused (keeps it around for one more action)
      #     use('msg', false)   # marks the "msg" entry as unused (keeps it around for one more action)
      def use(k=nil, v=true)
        unless k.nil?
          @used[k] = v
        else
          keys.each{|key| use key, v }
        end
      end
  end
end