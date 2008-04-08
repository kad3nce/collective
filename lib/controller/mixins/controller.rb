module Merb
  module ControllerMixin
    # Redirects to the specified url, then calls the block outside the mutex
    # and after the redirect has been returned to the client.
    #
    # ==== Parameters
    # url<String>:: A +String+ containing a url to return to the client.
    # &blk:: A block that should get called once the string has been returned.
    #
    # ==== Returns
    # Proc::
    #   A block that Mongrel can call after returning the string to the user.
    def redirect_then_call(url, &blk)
      must_support_streaming!
      self.status = 302
      headers['Location'] = url
      message = "<html><body>You are being <a href=\"#{url}\">redirected</a>.</body></html>"
      Proc.new {|response|
        response.send_status(message.length)
        response.send_header
        response.write(message)
        blk.call        
      }      
    end
  end
end