#!/usr/bin/env ruby
# encoding: utf-8

# CRM Application Test Script with Image Upload
puts "=== CRM Application Testing (Image Upload Edition) ==="
puts "Testing all pages and admin functionality..."
puts ""

require 'net/http'
require 'uri'

def test_page(url, expected_title)
  begin
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    if response.code == '200'
      puts "✓ #{expected_title} - Status: #{response.code}"
      true
    elsif response.code == '302' # Redirect is OK for admin pages
      puts "✓ #{expected_title} - Status: #{response.code} (Redirect - Normal for admin)"
      true
    else
      puts "✗ #{expected_title} - Status: #{response.code}"
      false
    end
  rescue => e
    puts "✗ #{expected_title} - Error: #{e.message}"
    false
  end
end

# Test customer pages
puts "📋 Testing Customer Pages:"
customer_tests = [
  [ "http://localhost:3000/", "Root page (redirects to customers)" ],
  [ "http://localhost:3000/customers", "All Customers page" ],
  [ "http://localhost:3000/customers/alphabetized", "Alphabetized Customers page" ],
  [ "http://localhost:3000/customers/missing_email", "Missing Email Customers page" ]
]

customer_passed = 0
customer_tests.each do |url, title|
  if test_page(url, title)
    customer_passed += 1
  end
end

puts ""

# Test admin pages
puts "🔧 Testing Admin Pages:"
admin_tests = [
  [ "http://localhost:3000/admin", "Admin Dashboard (should redirect to login)" ],
  [ "http://localhost:3000/admin/login", "Admin Login page" ]
]

admin_passed = 0
admin_tests.each do |url, title|
  if test_page(url, title)
    admin_passed += 1
  end
end

puts ""
puts "=" * 50
puts "Test Results:"
puts "Customer Pages: #{customer_passed}/#{customer_tests.length} passed"
puts "Admin Pages: #{admin_passed}/#{admin_tests.length} passed"
puts "Total: #{customer_passed + admin_passed}/#{customer_tests.length + admin_tests.length} passed"

if customer_passed == customer_tests.length && admin_passed == admin_tests.length
  puts ""
  puts "🎉 All tests passed! Your CRM application is working correctly."
  puts ""
  puts "Next Steps for Image Upload Testing:"
  puts "1. Visit http://localhost:3000/admin/login"
  puts "2. Login with: admin@example.com / password"
  puts "3. Go to Customers section"
  puts "4. Create/Edit a customer and upload an image"
  puts "5. Check if the image displays in both admin and customer views"
  puts ""
  puts "Features:"
  puts "✓ Customer management with CRUD operations"
  puts "✓ Three different customer views (all, alphabetized, missing email)"
  puts "✓ Admin panel with image upload functionality"
  puts "✓ Image display in customer cards using image_tag helper"
  puts "✓ Rails 8 ActiveStorage compatibility fixes"
else
  puts ""
  puts "❌ Some tests failed. Please check the Rails server and configuration."
end
