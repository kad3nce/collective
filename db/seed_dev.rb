Merb.logger.info('Seeding development database')

Page.create! \
  :name => 'Isolated controller/view specifications', 
  :content => <<-CONTENT
You a few hackish options for accomplishing this right now, as it's not yet officially supported:

* Use "Tim Connor's Hack":http://www.timocracy.com/articles/2007/12/17/isolated-controller-and-view-testing-in-merb
* Roll your own helper that short-circuits the render method of the controller mixin
CONTENT