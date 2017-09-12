module ThumbnailImages
  class Column
    attr_reader :height

    def initialize
      @images = []
      @height = 0
    end

    def add(image)
      @images.push image
      @height += image.height
    end

    def size
      @images.size
    end

    def <=>(other)
      height <=> other.height
    end
  end
end
