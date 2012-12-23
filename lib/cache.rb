require 'yaml'

# The Cache class is the basis of Cache. It stores data persistantly in a series
# of YAML files in a location specified by CACHE_LOCATION.
class Cache

  # The extension for all files created by Cache
  EXT = 'yaml'

  class << self
    # Set where the cache is located
    attr_writer :cache_location

    # Where the cache is located. Set to ~/.cache by default
    def cache_location
      @cache_location || File.join(ENV['HOME'], '.cache')
    end

    # Makes sure the cache folder exists, and creates it if it doesn't
    def ensure_cache_exists
      Dir.mkdir(cache_location) unless File.exists?(cache_location)
    end

    # Set what Cache should do if the database file is corrupt.
    # Valid choices are:
    # * :error - raise an exception
    # * :overwrite - create a blank database file and overwrite on save
    def behaviour_on_corrupt_file= behaviour
      unless [:error, :overwrite].include? behaviour
        raise ArgumentError, "Cache::behaviour_on_corrupt_file takes :error or :overwrite as arguments, you gave it #{behaviour}."
      end
      @behaviour_on_corrupt_file = behaviour
    end

    # Behaviour if a database file is corrupt. Default is :overwrite
    def behaviour_on_corrupt_file
      @behaviour_on_corrupt_file || :overwrite
    end
  end

  # The name of this particular cache
  attr_accessor :name

  # The data hash itself
  attr_reader :data

  # Returns an array of all caches 
  def self.all
    return Dir[File.join(Cache::cache_location, "*.#{EXT}")].map{ |f| File.basename(f,".#{EXT}") }
  end

  # The same as Cache.new(name)
  def self.[] name
    new(name)
  end

  # Retrieve a new cache from file. If the file appears corrupt,
  # Cache will issue an error message and initialize a blank hash.
  # To change this behaviour, you may wish to set Cache::override_on_error
  # or Cache::break_on_error
  def initialize name
    @name = name

    @data = if file_exists?
      begin
        YAML::load_file(file)
      rescue
        raise $! if Cache::behaviour_on_corrupt_file == :error
      end
    end

    @data ||= {}
  end

  # Location of cache file
  def file
    @file ||= File.join(Cache::cache_location, "#{@name}.#{EXT}")
  end

  # Does the file exist yet?
  def file_exists?
    File.exists?(file)
  end

  # Save this cache to file
  def save
    Cache::ensure_cache_exists
    File.open(file,'w'){ |io| io.puts YAML::dump(@data) }
  end

  # For everything else, there's method_missing
  def method_missing sym, *args, &blck
    if @data.respond_to?(sym)
      @data.send(sym, *args, &blck)
    else
      super sym, *args, &blck
    end
  end

  # Returns the cache's name
  def to_s
    name
  end
end
