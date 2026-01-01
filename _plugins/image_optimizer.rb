# Image Optimizer Plugin for Jekyll
# Reduces image resolution to reasonable levels for web use
# Requires imagemagick to be available in the build environment

Jekyll::Hooks.register :site, :post_write do |site|
  puts "Optimizing images for web..."
  
  # Configuration
  max_width = 1200
  max_height = 1200
  quality = 85
  
  # Find all PNG and JPG images in the site output
  image_files = Dir.glob(File.join(site.dest, '**', '*.{png,jpg,jpeg,PNG,JPG,JPEG}'))
  
  image_files.each do |image_path|
    # Skip if file doesn't exist or is too small to optimize
    next unless File.exist?(image_path)
    
    original_size = File.size(image_path)
    next if original_size < 10_000 # Skip files smaller than 10KB
    
    # Use ImageMagick to resize and optimize
    # -resize: only resize if larger than max dimensions (use '>' flag)
    # -strip: remove metadata
    # -quality: set compression quality
    temp_path = "#{image_path}.tmp"
    
    cmd = "convert \"#{image_path}\" -resize #{max_width}x#{max_height}\\> -strip -quality #{quality} \"#{temp_path}\""
    
    if system(cmd)
      # Replace original with optimized version
      FileUtils.mv(temp_path, image_path)
      new_size = File.size(image_path)
      
      if new_size < original_size
        saved = original_size - new_size
        saved_kb = (saved / 1024.0).round(1)
        percent = ((saved.to_f / original_size) * 100).round(1)
        puts "  ✓ #{File.basename(image_path)}: saved #{saved_kb}KB (#{percent}%)"
      else
        puts "  - #{File.basename(image_path)}: already optimized"
      end
    else
      puts "  ✗ Failed to optimize #{File.basename(image_path)}"
      File.delete(temp_path) if File.exist?(temp_path)
    end
  end
  
  puts "Image optimization complete!"
end
