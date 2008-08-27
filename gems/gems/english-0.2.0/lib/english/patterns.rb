module English

  # = Patterns Function Module
  #
  # Returns a Regexp pattern based on the given
  # pattern string or symbolic name.
  #
  # They are also recognizied in plural form.

  module Patterns

    module_function

    # Character

    def char
      //
    end

    alias_method :chars, :char
    alias_method :character, :char
    alias_method :characters, :char

    # Word

    def word
      /\s+|\Z/
    end

    alias_method :words, :word

    # Line

    def line
      /\Z/
    end

    alias_method :lines, :line

    # Sentence  FIXME

    def sentence
      /[.]\ /
    end

  end

end

