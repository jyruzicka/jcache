# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "cache"
  s.version = File.read('version.txt')
  
  s.summary = "Cache and restore data as hashes."
  s.description = "A simple means by which I can cache and restore data."
  
  s.author = 'Jan-Yves Ruzicka'
  s.email = 'janyves.ruzicka@gmail.com'
  s.homepage = 'https://github.com/jyruzicka/cache'
  
  s.files = File.read('Manifest').split("\n").select{ |l| !l.start_with?('#') && l != ''}
  s.require_paths << 'lib'
  s.bindir = 'bin'
  s.executables << 'cache'
  s.extra_rdoc_files = ['README.md']

  # Add runtime dependencies here
  #s.add_runtime_dependency 'commander', '~> 4.1.2'
end
