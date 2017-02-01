require 'mini_magick'
require 'fileutils'

A4_WIDTH = 1654
A4_HEIGHT = 2339
COLS = 5
THUMB_WIDTH = A4_WIDTH / COLS
LAST_THUMB_WIDTH = A4_WIDTH - THUMB_WIDTH * (COLS - 1)

images = Dir.glob 'img/*.jpg'
total_images = 0
MiniMagick::Tool::Convert.new do |b|
  b.size "#{A4_WIDTH}x#{A4_HEIGHT}"
  b << 'xc:white'
  v_offset = Hash.new 0
  images.each_with_index do |img, i|
    print '.'

    thumb_index = i % COLS
    thumb = MiniMagick::Image.open img
    thumb_width = (thumb_index == COLS - 1) ? LAST_THUMB_WIDTH : THUMB_WIDTH
    thumb.auto_orient
    thumb.resize "#{thumb_width}x"
    thumb_filename = "tmp/tmp_image_#{i}.jpg"
    thumb.write thumb_filename
    b << thumb_filename

    b.geometry "+#{THUMB_WIDTH * thumb_index}+#{v_offset[thumb_index]}"
    v_offset[thumb_index] += thumb.height
    b.composite
    total_images = i + 1
    break if v_offset.all? { |k, v| v > A4_HEIGHT }
  end
  b << 'output/events.jpg'
end
FileUtils.rm Dir.glob('tmp/*.jpg')
puts "Complete! Processed #{total_images} image files."
