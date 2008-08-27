class Module

  # Combine modules.
  #
  #   module A
  #     def a; "a"; end
  #   end
  #
  #   module B
  #     def b; "b"; end
  #   end
  #
  #   C = A + B
  #
  #   class X; include C; end
  #
  #   X.new.a    #=> "a"
  #   X.new.b    #=> "b"
  #
  # Note that in the old version of traits.rb we cloned
  # modules and altered their copies. Eg.
  #
  #     def +(other)
  #       mod1 = other.clone
  #       mod2 = clone
  #       mod1.module_eval{ include mod2 }
  #     end
  #
  # Later it was realized that this thwarted the main
  # benefit that Ruby's concept of modules has over
  # traditional traits, inheritance.
  #
  #   CREDIT: Thomas Sawyer
  #   CREDIT: Robert Dober

  def +(other)
    base = self
    Module.new do
      include base
      include other
    end
  end

  # Subtract modules.
  #
  #   TODO: Should this use all instance_methods, not just public?
  #
  #   CREDIT: Thomas Sawyer
  #   CREDIT: Robert Dober

  def -(other)
    case other
    when Array
      subtract = instance_methods(true) & other.collect{|m| m.to_s}
    when Module
      subtract = instance_methods(true) & other.instance_methods(true)  # false?
    when String, Symbol
      subtract = instance_methods(true) & [other.to_s]
    end
    base = self
    Module.new do
      include base
      subtract.each{ |x| undef_method x }
    end
  end

  # Rename methods.
  #
  #   module A
  #     def a; "a"; end
  #   end
  #
  #   B = A * { :a => :b }
  #
  #   class X; include B; end
  #
  #   X.new.b    #=> "a"
  #
  #
  #   CREDIT: Thomas Sawyer
  #   CREDIT: Robert Dober

  def *(rename_map)
    base = self
    Module.new do
      include base
      rename_map.each do |from, to|
        alias_method to, from
        undef_method from
      end
    end
  end

end

