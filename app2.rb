require_relative 'lib/thumbnail_images'
require 'fileutils'

# ThumbnailImages.configure { |c| c.columns = 4 }
ThumbnailImages.process_images 'img'
