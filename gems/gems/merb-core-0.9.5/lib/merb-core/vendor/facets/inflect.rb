module Language

module English

  # = English Nouns Number Inflection.
  #
  # This module provides english singular <-> plural noun inflections.
  module Inflect

    @singular_of = {}
    @plural_of = {}

    @singular_rules = []
    @plural_rules = []

    class << self
      # Defines a general inflection exception case.
      #
      # ==== Parameters
      # singular<String>::
      #   singular form of the word
      # plural<String>::
      #   plural form of the word
      #
      # ==== Examples
      #
      # Here we define erratum/errata exception case:
      #
      # Language::English::Inflector.word "erratum", "errata"
      #
      # In case singular and plural forms are the same omit
      # second argument on call:
      #
      # Language::English::Inflector.word 'information'
      def word(singular, plural=nil)
        plural = singular unless plural
        singular_word(singular, plural)
        plural_word(singular, plural)
      end

      def clear(type = :all)
        if type == :singular || type == :all
          @singular_of = {}
          @singular_rules = []
          @singularization_rules, @singularization_regex = nil, nil
        end
        if type == :plural || type == :all
          @singular_of = {}
          @singular_rules = []
          @singularization_rules, @singularization_regex = nil, nil
        end
      end


      # Define a singularization exception.
      #
      # ==== Parameters
      # singular<String>::
      #   singular form of the word
      # plural<String>::
      #   plural form of the word
      def singular_word(singular, plural)
        @singular_of[plural] = singular
        @singular_of[plural.capitalize] = singular.capitalize
      end

      # Define a pluralization exception.
      #
      # ==== Parameters
      # singular<String>::
      #   singular form of the word
      # plural<String>::
      #   plural form of the word
      def plural_word(singular, plural)
        @plural_of[singular] = plural
        @plural_of[singular.capitalize] = plural.capitalize
      end

      # Define a general rule.
      #
      # ==== Parameters
      # singular<String>::
      #   ending of the word in singular form
      # plural<String>::
      #   ending of the word in plural form
      # whole_word<Boolean>::
      #   for capitalization, since words can be
      #   capitalized (Man => Men)      #
      # ==== Examples
      # Once the following rule is defined:
      # Language::English::Inflector.rule 'y', 'ies'
      #
      # You can see the following results:
      # irb> "fly".plural
      # => flies
      # irb> "cry".plural
      # => cries
      # Define a general rule.

      def rule(singular, plural, whole_word = false)
        singular_rule(singular, plural)
        plural_rule(singular, plural)
        word(singular, plural) if whole_word
      end

      # Define a singularization rule.
      #
      # ==== Parameters
      # singular<String>::
      #   ending of the word in singular form
      # plural<String>::
      #   ending of the word in plural form
      #
      # ==== Examples
      # Once the following rule is defined:
      # Language::English::Inflector.singular_rule 'o', 'oes'
      #
      # You can see the following results:
      # irb> "heroes".singular
      # => hero
      def singular_rule(singular, plural)
        @singular_rules << [singular, plural]
      end

      # Define a plurualization rule.
      #
      # ==== Parameters
      # singular<String>::
      #   ending of the word in singular form
      # plural<String>::
      #   ending of the word in plural form
      #
      # ==== Examples
      # Once the following rule is defined:
      # Language::English::Inflector.singular_rule 'fe', 'ves'
      #
      # You can see the following results:
      # irb> "wife".plural
      # => wives
      def plural_rule(singular, plural)
        @plural_rules << [singular, plural]
      end

      # Read prepared singularization rules.
      def singularization_rules
        if defined?(@singularization_regex) && @singularization_regex
          return [@singularization_regex, @singularization_hash]
        end
        # No sorting needed: Regexen match on longest string
        @singularization_regex = Regexp.new("(" + @singular_rules.map {|s,p| p}.join("|") + ")$", "i")
        @singularization_hash  = Hash[*@singular_rules.flatten].invert
        [@singularization_regex, @singularization_hash]
      end

      # Read prepared pluralization rules.
      def pluralization_rules
        if defined?(@pluralization_regex) && @pluralization_regex
          return [@pluralization_regex, @pluralization_hash]
        end
        @pluralization_regex = Regexp.new("(" + @plural_rules.map {|s,p| s}.join("|") + ")$", "i")
        @pluralization_hash  = Hash[*@plural_rules.flatten]
        [@pluralization_regex, @pluralization_hash]
      end

      attr_reader :singular_of, :plural_of

      # Convert an English word from plurel to singular.
      #
      #   "boys".singular      #=> boy
      #   "tomatoes".singular  #=> tomato
      #
      # ==== Parameters
      # word<String>:: word to singularize
      #
      # ==== Returns
      # <String>:: singularized form of word
      #
      # ==== Notes
      # Aliased as singularize (a Railism)
      def singular(word)
        if result = singular_of[word]
          return result.dup
        end
        result = word.dup
        regex, hash = singularization_rules
        result.sub!(regex) {|m| hash[m]}
        singular_of[word] = result
        return result
      end

      # Alias for #singular (a Railism).
      #
      alias_method(:singularize, :singular)

      # Convert an English word from singular to plurel.
      #
      #   "boy".plural     #=> boys
      #   "tomato".plural  #=> tomatoes
      #
      # ==== Parameters
      # word<String>:: word to pluralize
      #
      # ==== Returns
      # <String>:: pluralized form of word
      #
      # ==== Notes
      # Aliased as pluralize (a Railism)
      def plural(word)
        # special exceptions
        return "" if word == ""
        if result = plural_of[word]
          return result.dup
        end
        result = word.dup
        regex, hash = pluralization_rules
        result.sub!(regex) {|m| hash[m]}
        plural_of[word] = result
        return result
      end

      # Alias for #plural (a Railism).
      alias_method(:pluralize, :plural)
    end

    # One argument means singular and plural are the same.

    word 'equipment'
    word 'information'
    word 'money'
    word 'species'
    word 'series'
    word 'fish'
    word 'sheep'
    word 'moose'
    word 'hovercraft'
    word 'grass'
    word 'rain'
    word 'milk'
    word 'rice'
    word 'plurals'

    # Two arguments defines a singular and plural exception.

    word 'Swiss'     , 'Swiss'
    word 'life'      , 'lives'
    word 'wife'      , 'wives'
    word 'goose'     , 'geese'
    word 'criterion' , 'criteria'
    word 'alias'     , 'aliases'
    word 'status'    , 'statuses'
    word 'axis'      , 'axes'
    word 'crisis'    , 'crises'
    word 'testis'    , 'testes'
    word 'potato'    , 'potatoes'
    word 'tomato'    , 'tomatoes'
    word 'buffalo'   , 'buffaloes'
    word 'torpedo'   , 'torpedoes'
    word 'quiz'      , 'quizzes'
    word 'matrix'    , 'matrices'
    word 'vertex'    , 'vertices'
    word 'index'     , 'indices'
    word 'ox'        , 'oxen'
    word 'mouse'     , 'mice'
    word 'louse'     , 'lice'
    word 'thesis'    , 'theses'
    word 'thief'     , 'thieves'
    word 'analysis'  , 'analyses'
    word 'erratum'   , 'errata'
    word 'phenomenon', 'phenomena'
    word 'octopus'   , 'octopi'
    word 'thesaurus' , 'thesauri'
    word 'movie'     , 'movies'
    word 'cactus'    , 'cacti'
    word 'plus'      , 'plusses'
    word 'cross'     , 'crosses'
    word 'medium'    , 'media'
    word 'cow'       , 'kine'
    word 'datum'     , 'data'
    word 'basis'     , 'bases'
    word 'diagnosis' , 'diagnoses'    
    
    # One-way singularization exception (convert plural to singular).

    # General rules.
    rule 'person' , 'people', true
    rule 'shoe'   , 'shoes', true
    rule 'hive'   , 'hives', true
    rule 'man'    , 'men', true
    rule 'child'  , 'children', true
    rule 'news'   , 'news', true
    rule 'rf'   , 'rves'
    rule 'af'   , 'aves'
    rule 'ero'  , 'eroes'
    rule 'man'  , 'men'
    rule 'ch'   , 'ches'
    rule 'sh'   , 'shes'
    rule 'ss'   , 'sses'
    rule 'ta'   , 'tum'
    rule 'ia'   , 'ium'
    rule 'ra'   , 'rum'
    rule 'ay'   , 'ays'
    rule 'ey'   , 'eys'
    rule 'oy'   , 'oys'
    rule 'uy'   , 'uys'
    rule 'y'    , 'ies'
    rule 'x'    , 'xes'
    rule 'lf'   , 'lves'
    rule 'ffe'  , 'ffes'
    rule 'afe'  , 'aves'
    rule 'ouse' , 'ouses'
    # more cases of words ending in -oses not being singularized properly
    # than cases of words ending in -osis
#    rule 'osis' , 'oses'
    rule 'ox'   , 'oxes'
    rule 'us'   , 'uses'
    rule ''     , 's'

    # One-way singular rules.

    singular_rule 'of' , 'ofs' # proof
    singular_rule 'o'  , 'oes' # hero, heroes
    singular_rule 'f'  , 'ves'

    # One-way plural rules.

    #plural_rule 'fe' , 'ves' # safe, wife
    plural_rule 's'   , 'ses'
    plural_rule 'ive' , 'ives' # don't want to snag wife
    plural_rule 'fe'  , 'ves'  # don't want to snag perspectives  
    

  end
end
end

class String
  def singular
    Language::English::Inflect.singular(self)
  end
  alias_method(:singularize, :singular)
  def plural
    Language::English::Inflect.plural(self)
  end
  alias_method(:pluralize, :plural)
end
