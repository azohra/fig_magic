$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../', 'lib'))

require 'rspec/expectations'
require 'fig_magic'

Before do
  FigMagic.yml_directory = nil
  FigMagic.yml = nil
end
