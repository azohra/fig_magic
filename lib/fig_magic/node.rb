require File.dirname(__FILE__) + "/missing"

module FigMagic
  class Node
    include FigMagic::Missing

    def initialize(yml)
      @yml = yml
    end

    def to_hash
      @yml
    end
  end
end
