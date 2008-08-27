unless defined?(Merb::Plugins)
  raise %q{merb_has_flash says, "Something's not right, bub.  You should run me inside Merb, or at least cheat and define a Merb::Plugins constant."}
end

require 'merb_has_flash/flash_hash'

require 'merb_has_flash/controller_extension'
Merb::Controller.send :include, MerbHasFlash::ControllerExtension

require 'merb_has_flash/helper'
Merb::RenderMixin.send :include, MerbHasFlash::FlashHelperMixin

module MerbHasFlash
  # The flash provides a way to pass temporary objects between actions. Anything you place in the flash will be exposed
  # to the very next action and then cleared out. This is a great way of doing notices and alerts, such as a create action
  # that sets <tt>flash[:notice] = "Successfully created"</tt> before redirecting to a display action that can then expose 
  # the flash to its template. Actually, that exposure is automatically done. Example:
  #
  #   class WeblogController < Merb::Controller
  #     def create
  #       # save post
  #       flash[:notice] = "Successfully created post"
  #       redirect_to :action => "display", :params => { :id => post.id }
  #     end
  #
  #     def display
  #       # doesn't need to assign the flash notice to the template, that's done automatically
  #       render
  #     end
  #   end
  #
  #   display.html.erb
  #     <% if flash[:notice] %><div class="notice"><%= flash[:notice] %></div><% end %>
  #
  # This example just places a string in the flash, but you can put any object in there. And of course, you can put as many
  # as you like at a time too. Just remember: They'll be gone by the time the next action has been performed.
  #
  # See docs on the FlashHash class for more details about the flash.
end