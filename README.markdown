Collective
==========

A no-frills wiki built on Merb 0.9.x and DataMapper 0.9.x
 
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
* $ cp config/database.yml.sample config/database.yml
* $ cp config/collective.yml.sample config/collective.yml
* $ rake db:bootstrap
* $ merb
* Open a browser at http://localhost:4000/

Dependencies required
---------------------

Merb 0.9.5:

<pre>
$ gem install merb -v 0.9.5
</pre>

DataMapper 0.9.5:

<pre>
$ gem install datamapper -v 0.9.5
$ gem install merb_datamapper -v 0.9.5
$ gem install data_objects -v 0.9.5
$ gem install do_sqlite3 (or) do_mysql (or) do_postgres -v 0.9.5
</pre>

RedCloth 3.0.4:

<pre>
$ gem install RedCloth -v 3.0.4
</pre>

Viking Gem 0.0.2:

<pre>
$ gem install vikinggem -v 0.0.2
</pre>

Diff Lcs 1.1.2:

<pre>
$ gem install diff-lcs -v 1.1.2  
</pre>

  
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
