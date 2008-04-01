Merb.logger.info('Seeding development database')

Page.create! \
  :name => 'Isolated controller/view specifications', 
  :content => <<-CONTENT
You have multiple options for accomplishing right now, as it's not officially supported:

* Use "Tim Connor's Hack":http://www.timocracy.com/articles/2007/12/17/isolated-controller-and-view-testing-in-merb
* Roll your own helper that short-circuits the render method of the controller mixin
CONTENT