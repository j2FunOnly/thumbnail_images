module ThumbnailImages
  class ColumnsList
    attr_reader :columns

    def initialize(config)
      @columns = []
      @images = 0

      config.columns.times do
        @columns.push Column.new(config.column_width)
      end
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
