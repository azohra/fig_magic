require 'fig_magic/date_translation'
require 'fig_magic/standard_translation'

module FigMagic
  class Translation
    include StandardTranslation
    include DateTranslation

    def initialize(parent)
      @parent = parent
    end

  end
end
