require 'dotenv/load'

require_relative 'lib/thumbnail_images'

namespace :images do
  desc 'Convert images to one big combined image'
  task :convert, [:path,:columns, :debug, :padding, :list_height] do
    ThumbnailImages.configure do |c|
      c.columns = ENV.fetch('CONVERTER_COLUMNS', 4)
      c.list_height = ENV.fetch('CONVERTER_LIST_HEIGHT', 2)
      c.padding = ENV.fetch('CONVERTER_PADDING', c.padding)
      c.debug = ENV.fetch('CONVERTER_DEBUG', false)
    end

    ThumbnailImages.process_images 'img'
  end
end
