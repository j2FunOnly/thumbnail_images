require_relative 'lib/thumbnail_images'
require 'fileutils'

ThumbnailImages.configure do|c|
  # c.columns = 6
  # c.list_height = 1
  c.padding = 10
  c.debug = true
end

# ThumbnailImages.process_images 'spec/fixtures/images'
ThumbnailImages.process_images 'img'
