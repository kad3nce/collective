Collective
==========

A no-frills wiki built on Merb 0.9.x and DataMapper
 
Features/Problems
-----------------
 
* Versioned pages
* Textile/Markdown content formatting
* Pretty page urls
* Custom theme support
  
Take It For A Spin
------------------
 
* $ git clone git://github.com/meekish/collective.git
* $ cd collective
* $ cp config/database.sample.yml config/database.yml
* $ cp config/collective.sample.yml config/collective.yml
* $ rake db:bootstrap
* $ merb
* Open a browser at http://localhost:4000/
  
Spam Protection
---------------

Collective supports protection against spam using either the Akismet or
Defensio API via Viking. By default this support is disabled. To enable
support you will need to create a configuration file named 
spam\_protection.yml in the config directory. A sample file is available
for you in  config/spam\_protection.yml.sample.

Your configuration file must:
  * have the name of your desired spam protection service. Available options
    include: 'akismet', 'defensio', or blank (i.e. disabled).
  * have both your API key and 'blog' connection options included. See the
    documentation for your service of choice for details on these options.

Lend A Hand
-----------

Check out the [bug tracker](http://falsetto.lighthouseapp.com/projects/11142-collective/overview).
Pull requests and patches are welcomed.
