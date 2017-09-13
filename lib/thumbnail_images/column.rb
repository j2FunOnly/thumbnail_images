module ThumbnailImages
  class Column
    attr_reader :height, :images

    def initialize(width)
      @images = []
      @height = 0
      @width = width
    end

    def add_and_resize(filename)
      image = MiniMagick::Image.open filename

      image.combine_options do |i|
        i.auto_orient
        i.resize "#{@width}x"
      end

      image.combine_options do |i|
        i.background 'none'
        i.fill 'none'
        i.stroke 'white'
        i.strokewidth 5
        i.draw 'roundrectangle 0,0,%s,%s,%s,%s' % [image.width, image.height, 5, 5]
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
