require 'mini_magick'

A4_WIDTH = 1654
A4_HEIGHT = 2339
COLS = 5
THUMB_WIDTH = A4_WIDTH / COLS
LAST_THUMB_WIDTH = A4_WIDTH - THUMB_WIDTH * (COLS - 1)

images = Dir.glob 'img/*.jpg'
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
    thumb.write "tmp/tmp_photo_#{i}.jpg"
    b << "tmp/tmp_photo_#{i}.jpg"

    b.geometry "+#{THUMB_WIDTH * thumb_index}+#{v_offset[thumb_index]}"
    v_offset[thumb_index] += thumb.height
    b.composite
    break if v_offset.all? { |k, v| v > A4_HEIGHT }
  end
  b << 'output/events.jpg'
end
