module WestLondonCoders
  module ImageQuality
    include CarrierWave::MiniMagick

    def optimise_jpg(options = { quality: 76, progressive: false })
      manipulate! do |img|
        img.format("jpg") do |c|
          c.quality(options[:quality].to_s)
          c.interlace "plane" if options[:progressive]
        end
        img
      end
    end
  end
end
