module ThumbnailImages
  class Column
    attr_reader :height, :images

    def initialize
      @images = []
      @height = 0
    end

    def add(filename)
      # image = ImageFile.new filename
      # @images.push image
      image = MiniMagick::Image.open filename
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
