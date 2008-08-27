class Hash

  # Can be used like update, or passed
  # as two-element [key,value] array.
  #
  #   CREDIT: Trans

  def <<(other)
    if other.respond_to?(:to_ary)
      self.store(*other)
    else
      update(other)
    end
  end

  # Iterates through each pair and updates a the hash
  # in place. This is formally equivalent to #mash!
  # But does not use #mash to accomplish the task.
  # Hence #update_each is probably a touch faster.
  #
  #  CREDIT: Trans

  def update_each  # :yield:
    dup.each do |k,v|
     update(yield(k,v))
    end
    self
  end

  # Iterate over hash updating just the keys.
  #
  #   h = {:a=>1, :b=>2}
  #   h.update_keys{ |k| "#{k}!" }
  #   h  #=> { "a!"=>1, "b!"=>2 }
  #
  #  CREDIT: Trans

  def update_keys #:yield:
    if block_given?
      keys.each { |old_key| store(yield(old_key), delete(old_key)) }
    else
      to_enum(:update_keys)
    end
  end

  # Iterate over hash updating just the values.
  #
  #   h = {:a=>1, :b=>2}
  #   h.update_values{ |v| v+1 }
  #   h  #=> { a:=>2, :b=>3 }
  #
  #  CREDIT: Trans

  def update_values #:yield:
    if block_given?
      each{ |k,v| store(k, yield(v)) }
    else
      to_enum(:update_values)
    end
  end

  # Same as #update_each, but deletes the key element first.
  #
  #   CREDIT: Trans

  def replace_each  # :yield:
    dup.each do |k,v|
      delete(k)
      update(yield(k,v))
    end
    self
  end

end

