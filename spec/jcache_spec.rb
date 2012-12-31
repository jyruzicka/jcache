require './spec/spec_helper'
include JCache

describe JCache::Cache do

  before(:all) do
    test_cache_location = File.join(File.dirname(__FILE__), 'tmp')
    Cache.cache_location = test_cache_location
    Dir[File.join(test_cache_location, "*.yaml")].each do |f|
      File.unlink f
    end
  end

  describe "#initialize" do
    it "should make new caches with initialize methods and [] methods" do
      Cache.new('foo').data.should == {}
      Cache['bar'].data.should == {}
    end
  end

  describe "#save" do
    it "should serialize" do
      c = Cache['foo']
      c[:bar] = 3
      c.save

      Cache['foo'][:bar].should == 3
    end
  end

  describe "#behaviour_on_corrupt_file" do
    before(:each) do
      corrupt_cache = File.join(Cache.cache_location, 'corrupt.yaml')
      File.open(corrupt_cache,'w'){ |io| io << 'not a yaml file' }
    end

    it "should overwrite by default" do
      Cache['corrupt'].data.should == {}
    end

    it "should error if the option is set" do
      Cache::behaviour_on_corrupt_file = :error
      expect{ Cache['corrupt'] }.to raise_exception
    end

    it "should not accept other options to behaviour_on_corrupt_file" do
      expect{ Cache::behaviour_on_corrupt_file = :not_an_option }.to raise_exception
    end
  end
end