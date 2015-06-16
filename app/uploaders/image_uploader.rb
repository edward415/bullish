class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  process resize_to_fill: [300, 300]
  
  version :thumb do
    process resize_to_fit: [50, 50]
  end
  
  version :large do 
    process resize_to_to: [200, 200]
  end
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
