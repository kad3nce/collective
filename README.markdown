# Collective

A no-frills wiki built on Merb 0.9.x and DataMapper
 
### Features/Problems
 
* Versioned pages
* Textile/Markdown content formatting
* Pretty page urls
* Markup and Styling still looks like wiki.merbivore.com
  
### Take It For A Spin
 
* git clone git://github.com/meekish/collective.git collective
* cd collective
* move database.sample.yml to database.yml
* merb
* open a browser at http://localhost:4000
  
### Caveat Emptor
 
The development database is auto migrated and seeded at every boot, so don't put anything in there that you want to keep

### Start Coding

* git clone git://github.com/meekish/collective.git (or make a fork)
* gem install ditz
* cd collective
* ditz todo