require_relative 'lib/thumbnail_images'

ThumbnailImages.configure do|c|
  # c.columns = 6
  # c.list_height = 1
  c.padding = 3
  c.debug = true
end

# ThumbnailImages.process_images 'spec/fixtures/images'
ThumbnailImages.process_images 'img'
