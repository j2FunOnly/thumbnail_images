module ThumbnailImages
  class ColumnsList
    attr_reader :columns

    def initialize(columns_count)
      @columns = []
      @images = 0
      columns_count.times { @columns.push Column.new }
    end

    def columns_count
      @columns.size
    end

    def size
      @images
    end

    def add(image)
      min_column.add image
      @images += 1
    end

    private

    def min_column
      @columns.min
    end
  end
end
