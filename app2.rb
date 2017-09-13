require_relative 'lib/thumbnail_images'
require 'fileutils'

ThumbnailImages.configure do|c|
  # c.columns = 1
  # c.list_height = 1
  c.debug = true
end

ThumbnailImages.process_images 'img'
