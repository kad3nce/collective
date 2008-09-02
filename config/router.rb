# Merb::Router is the request routing mapper for the merb framework.
#
# You can route a specific URL to a controller / action pair:
#
#   r.match("/contact").
#     to(:controller => "info", :action => "contact")
#
# You can define placeholder parts of the url with the :symbol notation. These
# placeholders will be available in the params hash of your controllers. For example:
#
#   r.match("/books/:book_id/:action").
#     to(:controller => "books")
#   
# Or, use placeholders in the "to" results for more complicated routing, e.g.:
#
#   r.match("/admin/:module/:controller/:action/:id").
#     to(:controller => ":module/:controller")
#
# You can also use regular expressions, deferred routes, and many other options.
# See merb/specs/merb/router.rb for a fairly complete usage sample.

Merb.logger.info("Compiling routes...")
Merb::Router.prepare do |r|
  r.match('/').to(:controller => 'pages', :action =>'show', :id => 'home').name(:home)
  r.resources :pages
  r.resources :edits
  r.resources :sessions
  r.match('/login').to(:controller => 'sessions', :action => 'create').name(:login)
  r.match('/logout', :method => :delete).to(:controller => 'sessions', :action => 'destroy').name(:logout)
  # r.resources :users
end