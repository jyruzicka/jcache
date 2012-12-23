require 'json'

# The Cache class is the basis of Cache. It stores data persistantly in a series
# of JSON files in a location specified by CACHE_LOCATION.
class Cache
  # Where the cache is located
  CACHE_LOCATION = File.join(ENV['HOME'], '.cache')

  # The name of this particular cache
  attr_accessor :name

  # The data hash itself
  attr_reader :data

  # Returns an array of all caches 
  def self.all
    return Dir[File.join(CACHE_LOCATION, "*.json")].map{ |f| File.basename(f,'.json') }
  end

  # The same as Cache.new(name)
  def self.[] name
    new(name)
  end

  # Retrieve a new cache from file
  def initialize name
    @name = name

    @data = if json_file_exists?
      JSON::parse(File.read(json_file))
    else
      {}
    end
  end

  # Location of cache json file
  def json_file
    @json_file ||= File.join(CACHE_LOCATION, "#{@name}.json")
  end

  # Does the json file exist yet?
  def json_file_exists?
    File.exists?(json_file)
  end

  # Save this cache to file
  def save
    ensure_dir_exists
    File.open(json_file,'w'){ |io| io.puts(JSON::pretty_generate @data) }
  end

  # For everything else, there's method_missing
  def method_missing sym, *args, &blck
    if @data.respond_to?(sym)
      @data.send(sym, *args, &blck)
    else
      super sym, *args, &blck
    end
  end

  # To_string uses cache name
  def to_s
    name
  end

  private

  # Ensure our cache directory exists
  def ensure_dir_exists
    Dir.mkdir(CACHE_LOCATION) unless File.exists?(CACHE_LOCATION)
  end
end
