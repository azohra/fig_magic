#DataMagic Requires
require 'fig_magic/core_ext/string'
require 'fig_magic/core_ext/fixnum'
require 'fig_magic/translation'
require 'fig_magic/date_translation'
require 'fig_magic/standard_translation'
require 'faker'

#FigNewton Requires
require 'fig_magic/node'
require 'fig_magic/missing'

#Shared Requires
require 'yml_reader'
require 'fig_magic/version'


module FigMagic
  extend YmlReader
  extend StandardTranslation
  extend DateTranslation
  extend FigMagic::Missing

  attr_reader :parent

  I18n.enforce_available_locales = false if I18n.respond_to? :enforce_available_locales

  def self.locale=(value)
    Faker::Config.locale = value
  end
  
  def self.included(cls)
    @parent = cls
    translators.each do |translator|
      Translation.send :include, translator
    end
  end

  def data_for(key, additional={})
    if key.is_a?(String) && key.match(%r{/})
      filename, record = key.split('/')
      FigMagic.load("#{filename}.yml")
    else
      record = key.to_s
      FigMagic.load(the_file) unless FigMagic.yml
    end
    data = FigMagic.yml[record]
    raise ArgumentError, "Undefined key #{key}" unless data
    prep_data data.merge(additional).clone
  end

  private

  def the_file
    ENV['DATA_MAGIC_FILE'] ? ENV['DATA_MAGIC_FILE'] :  'default.yml'
  end

  def prep_data(data)
    data.each do |key, value|
      unless value.nil?
        next if !value.respond_to?('[]') || value.is_a?(Numeric)
        next if value.is_a?(Hash)
        data[key] = translate(value[1..-1]) if value[0,1] == "~"
      end
    end
    data
  end

  def translate(value)
    translation.send :process, value
  end

  def translation
    @translation ||= Translation.new parent
  end

  class << self
    attr_accessor :yml
  
    def default_directory
      'config/'
    end

    def add_translator(translator)
      translators << translator
    end

    def translators
      @translators ||= []
    end
  end

end
