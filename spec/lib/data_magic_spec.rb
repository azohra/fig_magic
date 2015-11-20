require 'spec_helper'

class UserPage
  include FigMagic
end

describe FigMagic do
  context "when configuring the yml directory" do
    before(:each) do
      FigMagic.yml_directory = nil
    end
    
    it "should default to a directory named config" do
      expect(FigMagic.yml_directory).to eql 'config/data'
    end

    it "should store a yml directory" do
      FigMagic.yml_directory = 'test_dir'
      expect(FigMagic.yml_directory).to eql 'test_dir'
    end

    it "should accept and use locale" do
      expect(Faker::Config).to receive(:locale=).with('blah')
      FigMagic.locale = 'blah'
    end

  end

  context "when reading yml files" do
    it "should read files from the config directory" do
      FigMagic.yml_directory = 'test'
      expect(File).to receive(:read).with("test/fname").and_return('test')
      FigMagic.load("fname")
    end

    it "should default to reading a file named default.yml" do
      FigMagic.yml_directory = 'config/data'
      FigMagic.yml = nil
      data = UserPage.new.data_for :dm
      expect(data.keys).to include('value1')
    end

    it "should use the value of DATA_MAGIC_FILE if it exists" do
      FigMagic.yml_directory = 'config/data'
      FigMagic.yml = nil
      ENV['DATA_MAGIC_FILE'] = 'user.yml'
      data = UserPage.new.data_for "valid"
      expect(data.keys.sort).to eq(['job','name'])
      ENV['DATA_MAGIC_FILE'] = nil
    end
  end

  context "namespaced keys" do
    it "loads correct file and retrieves data" do
      FigMagic.yml_directory = 'config/data'
      data = UserPage.new.data_for "user/valid"
      expect(data.keys.sort).to eq(['job','name'])
    end
  end
end
