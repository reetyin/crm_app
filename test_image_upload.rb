#!/usr/bin/env ruby

# Test script for image upload functionality
require_relative 'config/environment'

puts "Testing image upload functionality..."
puts "=" * 50

# Find a customer
customer = Customer.first
puts "Testing with customer: #{customer.full_name} (ID: #{customer.id})"

# Check current image status
puts "Current image attached: #{customer.image_attached_safely?}"

if customer.image_attached_safely?
  puts "Current image filename: #{customer.image.filename}"
end

# Create a simple test image (1x1 pixel PNG)
require 'chunky_png'

# Create a 1x1 pixel image
png = ChunkyPNG::Image.new(1, 1, ChunkyPNG::Color::WHITE)

# Save to temp file
temp_file = Tempfile.new(['test_image', '.png'])
png.save(temp_file.path)

puts "Created test image at: #{temp_file.path}"

begin
  # Use the manual upload method
  success = customer.upload_image_from_file(temp_file.path, 'test_image.png')
  
  if success
    puts "✅ Image upload successful!"
    puts "Image attached: #{customer.image_attached_safely?}"
    if customer.image_attached_safely?
      puts "Image filename: #{customer.image.filename}"
      puts "Image content type: #{customer.image.content_type}"
    end
  else
    puts "❌ Image upload failed"
  end
  
rescue => e
  puts "❌ Image upload failed: #{e.message}"
  puts e.backtrace.first(5)
end

# Clean up
temp_file.close
temp_file.unlink

puts "=" * 50
puts "Test completed!" 