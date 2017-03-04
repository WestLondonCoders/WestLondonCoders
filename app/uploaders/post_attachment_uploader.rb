class PostAttachmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include WestLondonCoders::ImageQuality

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumbnail do
    process resize_to_fill: [300, 200]
    process optimise_jpg: [{ progressive: true, quality: 76 }]
  end

  version :promo_small do
    process resize_to_fill: [900, 360]
    process optimise_jpg: [{ progressive: true, quality: 76 }]
  end

  version :promo_medium do
    process resize_to_fill: [1250, 440]
    process optimise_jpg: [{ progressive: true, quality: 76 }]
  end

  version :promo_large do
    process resize_to_fill: [1600, 560]
    process optimise_jpg: [{ progressive: true, quality: 76 }]
  end

  version :header_small do
    process resize_to_fill: [476, 290]
    process optimise_jpg: [{ progressive: true, quality: 76 }]
  end

  version :header_medium do
    process resize_to_fill: [900, 260]
    process optimise_jpg: [{ progressive: true, quality: 76 }]
  end

  version :header_large do
    process resize_to_fill: [1920, 290]
    process optimise_jpg: [{ progressive: true, quality: 76 }]
  end
end
