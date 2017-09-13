require 'mini_magick'
require 'fileutils'

require_relative 'thumbnail_images/image_file'
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
      print 'Finding images...'
      images = Dir.glob "#{path}/*.jpg"
      list = ColumnsList.new(config.columns)
      images.each do |f|
        list.add f
        print '.'
      end
      puts

      column_files = []

      print 'Resizing...'
      list.columns.each_with_index do |column, column_i|
        MiniMagick::Tool::Convert.new do |b|
          b.size "#{config.column_width}x#{config.list_height}"
          b << 'xc:white'
          v_offset = 0

          column.images.each_with_index do |img, img_i|
            print '.'
            thumb = MiniMagick::Image.open img.filename
            thumb.auto_orient
            thumb.resize "#{config.column_width}x"
            thumb_filename = "tmp/tmp_image_#{column_i}_#{img_i}.jpg"
            thumb.write thumb_filename

            b << thumb_filename
            b.geometry "+0+#{v_offset}"
            v_offset += thumb.height
            b.composite
          end
          column_file = "tmp/column_#{column_i}.jpg"
          b << "tmp/column_#{column_i}.jpg"
          column_files << column_file
        end
      end

      puts

      print 'Building final image...'
      MiniMagick::Tool::Convert.new do |b|
        b.size "#{A4[:WIDTH]}x#{config.list_height}"
        b << 'xc:white'
        column_files.each_with_index do |f, i|
          print '.'
          b << f
          b.geometry "+#{config.column_width * i}+0"
          b.composite
        end
        b << 'output/events.jpg'
      end

      FileUtils.rm Dir.glob('tmp/*.jpg')
      puts
      puts 'Complete'
    end

  end
  extend ModuleMethods

end
