module ThumbnailImages
  class ImageFile
    attr_reader :width, :height, :filename

    def initialize(filename)
      image = MiniMagick::Image.open(filename)
      @filename = filename
      @width = image[:width]
      @height = image[:height]
    end
  end
end
