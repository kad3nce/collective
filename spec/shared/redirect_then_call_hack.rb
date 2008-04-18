module Merb
  module ControllerMixin
    def redirect_then_call(url, &blk)
      blk.call
      redirect(url)
    end
  end
end