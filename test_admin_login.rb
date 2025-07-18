#!/usr/bin/env ruby
# encoding: utf-8

require 'net/http'
require 'uri'
require 'openssl'

# Test ActiveAdmin login and check encoding
def test_admin_login
  puts "Testing ActiveAdmin login and encoding..."

  # Get login page to extract CSRF token
  uri = URI('http://localhost:3000/admin/login')
  http = Net::HTTP.new(uri.host, uri.port)

  # Get login page
  response = http.get(uri.path)

  # Check encoding
  puts "Login page encoding: #{response['content-type']}"

  # Check if page contains proper UTF-8 content
  if response.body.force_encoding('UTF-8').valid_encoding?
    puts "✅ Login page has valid UTF-8 encoding"
  else
    puts "❌ Login page has invalid UTF-8 encoding"
  end

  # Check for Chinese characters in test data
  test_uri = URI('http://localhost:3000/customers')
  test_response = http.get(test_uri.path)

  # Force UTF-8 encoding
  body_text = test_response.body.force_encoding('UTF-8')

  if body_text.include?('测试') && body_text.include?('中文')
    puts "✅ Main customer page displays Chinese characters correctly"
  else
    puts "❌ Main customer page has encoding issues with Chinese characters"
    puts "Response encoding: #{test_response.body.encoding}"
    puts "Content-Type: #{test_response['content-type']}"
  end
end

test_admin_login
