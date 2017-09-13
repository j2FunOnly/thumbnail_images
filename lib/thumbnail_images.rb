require 'mini_magick'
require 'fileutils'

require_relative 'thumbnail_images/column'
require_relative 'thumbnail_images/columns_list'
require_relative 'thumbnail_images/configuration'

module ThumbnailImages
  VERSION = '0.0.1'.freeze

  A4 = {WIDTH: 2339, HEIGHT: 1654}

  module ModuleMethods
    def config
      @config ||= Configuration.new
    end

    def configure(&block)
      yield config
    end

    def process_images(path = 'src')
      MiniMagick.logger.level = Logger::DEBUG if config.debug

      images = Dir.glob "#{path}/*.jpg"
      # list = ColumnsList.new(count: config.columns, width: config.column_width)
      list = ColumnsList.new(config)

      images.each do |f|
        list.add f
      end

      column_files = list.columns.map.with_index do |column, column_i|
        column_file = "tmp/column_#{column_i}.jpg"

        MiniMagick::Tool::Convert.new do |b|
          b.size "#{config.column_width}x#{config.list_height}"
          b << 'xc:white'
          v_offset = 0

          column.images.each do |img|
            b << img.path
            b.geometry "+0+#{v_offset}"
            v_offset += img.height + config.padding
            b.composite
          end

          b << column_file
        end

        column_file
      end

      MiniMagick::Tool::Convert.new do |b|
        b.size "#{A4[:WIDTH]}x#{config.list_height}"
        b << 'xc:white'
        column_files.each_with_index do |f, i|
          b << f
          b.geometry "+#{(config.column_width + config.padding) * i}+0"
          b.composite
        end
        b << 'output/events.jpg'
      end

      FileUtils.rm Dir.glob('tmp/*.jpg')
    end
  end
  extend ModuleMethods
end
