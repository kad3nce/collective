module Merb
    module SpamsHelper
      def spam_or_ham(version)
        version.spam ? 'spam' : 'ham'
      end
    end
end