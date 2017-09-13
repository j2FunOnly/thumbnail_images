module ThumbnailImages
  class Configuration
    attr_reader :columns, :column_width, :list_height
    attr_accessor :debug, :padding

    def initialize
      self.columns = 4
      self.list_height = 3
      @padding = 5
      @debug = false
    end

    def columns=(v)
      @columns = v
      @column_width = (A4[:WIDTH] - 5 * (columns - 1)) / columns
    end

    def list_height=(h)
      @list_height = A4[:HEIGHT] * h
    end
  end
end
