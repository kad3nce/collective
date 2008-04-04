# = About
# This is an adaptation of Technoweenie's Permalink-Fu Rails' plugin. It has 
# been adapted to fit the DataMapper paradigm. Some code is also inspired by 
# Blerb's Permalinker.
# 
# = How it Works
# This module injects into your model an attribute called 'slug'. This 
# attribute will contain a _unique_, URL-safe permalink for your model that is 
# based on the specified source attribute. For example:
# 
#   class Article < DataMapper::Base
#     include Permalinker
#     property :title
#     permalink_from :title
#   end
# 
# == Permalink Uniqueness
# Since it is entirely possible to generate permalinks that would clash with 
# another, non-unique permalinks are suffixed with a dash and a number should 
# a similar permalink already exist. Example: 'some-unique-permalink-2'.
#--
# To keep things from clashing in other namespaces, ensure that all private 
# methods are prefixed with "permalinker_"
require 'iconv'

module Permalinker
  
  module ClassMethods
    
    # Automatically generates a permalink provided a source attribute. The 
    # generated permalink will be written to a +slug+ attribute.
    # 
    # ==== Arguments
    # +source+<Symbol>:: the attribute that the permalink will be generated from
    # 
    # ==== Example
    # 
    #   class Post < DataMapper::Base
    #     permalink_from :title
    #   end
    # 
    #   > p = Post.new(:title => "Some title")
    #   > p.valid? # permalink generated in the +before_validation+ hook
    #   > p.permalink
    #   => "some-title"
    def permalink_from(source)
      
      ## Properties
      
      property :slug, :string
      
      ## Validations

      validates_presence_of   :slug
      validates_uniqueness_of :slug
      
      ## Call-backs
      
      # Sets the permalink if this is a new record. Permalinks are 
      # perma-nent. You don't want a new one each time the record is saved.
      before_validation do |record|
        record.set_slug( record.send(source) )
      end
      
    end
    
    # Finds records with a given slug.
    # 
    # ==== Arguments
    # +slug+<String>:: the slug to search by
    def by_slug(slug)
      find(:first, :slug => slug)
    end
  
    # Finds records with slugs that are like the provided. Slugs are 
    # considered alike when the start the same, but differ in their suffix.
    # 
    # ==== Arguments
    # +slug+<String>:: the slug to search by
    # 
    # ==== Returns
    # Array of records:: 
    #   records with a +slug+ like that which is specified
    def with_slug_like(slug)
      all(:slug.like => "#{slug}%")
    end
    
    # Determines the next suffix to use on a permalink to make it unique.
    # 
    # ==== Arguments
    # +permalink+<String>:: the permalink that may need a suffix
    # 
    # ==== Returns
    # Integer:: the number to use when suffixing the provided permalink
    # +nil+::   returned when the permalink doesn't need a suffix
    def next_permalink_suffix_for(permalink)
      unless ( records = with_slug_like(permalink) ).empty?
        records.collect(&:slug_suffix).compact.max.succ
      end
    end
    
  end
  
  module InstanceMethods
    
    # Sets a slug to a unique value for use as a permalink.
    # 
    # When a slug exists with the same name, it is made unique by 
    # appending a unique suffix in the form of "-<Integer>". This suffix is 
    # the successor of the previous.
    # 
    # ==== Arugments
    # +source+<String>:: the string to convert to a unique slug
    def set_slug(source)
      if new_record?
        self.slug = permalinker_make_unique( permalinker_escape(source) )
      end
    end
    
    # Returns the suffix that is on a slug.
    # 
    # ==== Returns
    # When the slug is:
    # +nil+::         +nil+
    # has no suffix:: 0
    # has a suffix::  the numeric value of the suffix
    def slug_suffix
      if slug
        md = slug.match(/-(\d)+$/)
        md ? md[0][1..-1].to_i : 0
      end
    end
    
  private
  
    # Converts a string into an URL-safe form. 
    # 
    # === Why We Don't URL Encode
    # URL-encoded strings are not nearly as legible as the form we generate 
    # with this method.  Suppose for example we wanted to genereate a 
    # permalink from the string 'I love tacos (and more)':
    # 
    #   # URI-escaped:
    #   > require 'uri'
    #   > str = "I love tacos (and more)"
    #   > URI.escape(str)
    #   => "I%20love%20tacos%20(and%20more)"
    # 
    #   # permalinker_escape'd:
    #   > permalinker_escape(str)
    #   => "i-love-tacos-and-more"
    # 
    # The latter is _much_ more legible.
    # 
    # ==== Arguments
    # +string+<String>:: the string to convert
    # 
    # ==== Returns
    # String:: a string escaped for use in an URL
    def permalinker_escape(string) # :nodoc:
      string = Iconv.iconv('ascii//translit//IGNORE', 'utf-8', string).to_s
      string.gsub!(/\W+/, ' ') # non-words to space
      string.strip!
      string.downcase!
      string.gsub!(/\s+/, '-') # all spaces to dashes
      string
    end
    
    # Finds all records with a slug similar to that generated thus far. 
    # This ensures slugs are unique.
    # 
    # ==== Arguments
    # +source+<String>:: the slug that must be made unique
    def permalinker_make_unique(source) # :nodoc:
      [source, self.class.next_permalink_suffix_for(source)].compact.join("-")
    end
    
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end