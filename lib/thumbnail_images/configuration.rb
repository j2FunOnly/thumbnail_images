module ThumbnailImages
  class Configuration
    attr_reader :columns, :column_width, :list_height, :padding
    attr_accessor :debug

    def initialize
      @padding = 5
      @debug = false

      self.columns = 4
      self.list_height = 3
    end

    def columns=(v)
      @columns = v.to_i
      @column_width = (A4[:WIDTH] - @padding * (columns - 1)) / columns
    end

    def list_height=(h)
      @list_height = A4[:HEIGHT] * h.to_i
    end

    def padding=(v)
      @padding = v.to_i
    end
  end
end
