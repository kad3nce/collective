module Merb
    module EditsHelper
      def spam_or_ham(version)
        version.spam ? 'spam' : 'ham'
      end
      
      def mark_as_ham_or_spam(version)
        open_tag('button', :type => 'submit') +
          (version.spam ? 'Mark as Ham' : 'Mark as Spam') + 
          "</button>"
      end
    end
end