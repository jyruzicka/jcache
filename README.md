# JCache

JCache is very simple. Use `JCache::Cache` instances like hashes, and save/load them as you wish.

    c = JCache::Cache.new('foo') # or JCache::Cache['foo']
    c[:key] = 3
    c.save

    d = JCache::Cache.new('foo') # the same cache!
    d[:key] #=> 3

## History

### 1.0.0 / 2013-01-01

* [FIXED] Now uses the JCache namespace, so as not to collide with the `cache` gem. Renamed to JCache
* [NEW] A whole suite of tests.

### 0.2.0 / 2012-12-23

* [NEW] Switched to YAML storage - allows for symbols!

### 0.1.2 / 2012-12-23

* [NEW] Cache['foo'] added - the same as Cache.new('foo')

### 0.1.1 / 2012-12-15

* [NEW] Added the Cache#all function
* [NEW] Added a binary - cache - which will display what's in the cache