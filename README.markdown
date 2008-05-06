Collective
==========

A no-frills wiki built on Merb 0.9.x and DataMapper
 
Features/Problems
-----------------
 
* Versioned pages
* Textile/Markdown content formatting
* Pretty page urls
* Markup and Styling still looks like wiki.merbivore.com
  
Take It For A Spin
------------------
 
* $ git clone git://github.com/meekish/collective.git
* $ cd collective
* $ cp config/database.sample.yml config/database.yml
* $ rake db:bootstrap
* $ merb
* Open a browser at http://localhost:4000/
  
Spam Protection
---------------

Collective supports protection against spam using either the Akismet or Defensio API via Viking. By default this support is disabled. To enable support you will need to create a configuration file named spam\_protection.yml in the config directory. A sample file is available for you in  config/spam\_protection.yml.sample.

Your configuration file must:
  * have the name of your desired spam protection service. Available options include: 'akismet', 'defensio', or blank (i.e. disabled).
  * have both your API key and 'blog' connection options included. See the documentation for your service of choice for details on these options.

Caveat Emptor
-------------
 
The development database is auto migrated and seeded at every boot, so don't put anything in there that you want to keep

Lend A Hand
-----------

* git clone git://github.com/meekish/collective.git (or make a fork)
* gem install ditz
* cd collective
* ditz todo
