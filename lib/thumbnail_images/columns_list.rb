module ThumbnailImages
  class ColumnsList
    attr_reader :columns

    def initialize(count: 1, width:)
      @columns = []
      @images = 0
      count.times { @columns.push Column.new(width) }
    end

    def columns_count
      @columns.size
    end

    def size
      @images
    end

    def add(filename)
      min_column.add_and_resize filename
      @images += 1
    end

    private

    def min_column
      @columns.min
    end
  end
end
