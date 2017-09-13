module ThumbnailImages
  class Column
    attr_reader :height, :images

    def initialize(width)
      @images = []
      @height = 0
      @width = width
    end

    def add_and_resize(filename)
      # image = ImageFile.new filename
      # @images.push image
      image = MiniMagick::Image.open filename

      image.combine_options do |i|
        i.auto_orient
        i.resize "#{@width}x"
      end

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
