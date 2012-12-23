# Cache

Cache is very simple. Use `Cache` instances like hashes, and save/load them as you wish.

    c = Cache.new('foo') # or Cache['foo']
    c[:key] = 3
    c.save

    d = Cache.new('foo') # the same cache!
    d[:key] #=> 3

## History

### 0.2.0 / 2012-12-23

* [NEW] Switched to YAML storage - allows for symbols!

### 0.1.2 / 2012-12-23

* [NEW] Cache['foo'] added - the same as Cache.new('foo')

### 0.1.1 / 2012-12-15

* [NEW] Added the Cache#all function
* [NEW] Added a binary - cache - which will display what's in the cache