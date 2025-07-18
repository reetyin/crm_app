# Image Upload Guide

Due to Rails 8 compatibility issues with Active Storage in Active Admin, image uploads need to be done through the Rails console.

## How to Upload Images

### 1. Start Rails Console
```bash
rails console
```

### 2. Find a Customer
```ruby
customer = Customer.find(1)  # Replace 1 with the customer ID
```

### 3. Upload an Image
```ruby
# Method 1: Upload from a file path
customer.image.attach(
  io: File.open('/path/to/your/image.jpg'),
  filename: 'profile.jpg',
  content_type: 'image/jpeg'
)

# Method 2: Upload from a URL (requires net/http)
require 'net/http'
require 'open-uri'

url = 'https://example.com/image.jpg'
customer.image.attach(
  io: URI.open(url),
  filename: 'profile.jpg',
  content_type: 'image/jpeg'
)
```

### 4. Verify Upload
```ruby
customer.image_attached_safely?  # Should return true
customer.image.filename          # Should show the filename
```

### 5. Save the Customer
```ruby
customer.save
```

## Example Session
```ruby
# Find customer with ID 1
customer = Customer.find(1)
puts "Customer: #{customer.full_name}"

# Upload image (replace with actual path)
customer.image.attach(
  io: File.open('/Users/username/Desktop/profile.jpg'),
  filename: 'profile.jpg',
  content_type: 'image/jpeg'
)

# Verify
puts "Image attached: #{customer.image_attached_safely?}"
puts "Filename: #{customer.image.filename}"

# Save
customer.save
puts "Customer updated successfully!"
```

## Notes
- Images will automatically display in the customer views once attached
- The `image_attached_safely?` method handles Rails 8 compatibility issues
- Supported image formats: JPEG, PNG, GIF, etc.
- Images are stored using Active Storage and will be accessible via the customer partial 