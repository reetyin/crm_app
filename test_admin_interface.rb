#!/usr/bin/env ruby
# Test script for ActiveAdmin interface

require 'net/http'
require 'uri'

def test_admin_interface
  puts "=== Testing ActiveAdmin Interface ==="

  base_url = "http://localhost:3000"

  # Test admin login page
  begin
    uri = URI("#{base_url}/admin/login")
    response = Net::HTTP.get_response(uri)

    if response.code == '200'
      puts "✅ Admin login page: WORKING"
      puts "   Status: #{response.code}"
      puts "   Content-Type: #{response['content-type']}"

      # Check if UTF-8 is properly supported
      if response['content-type'].include?('charset=utf-8')
        puts "   ✅ UTF-8 encoding: SUPPORTED"
      else
        puts "   ⚠️  UTF-8 encoding: NOT EXPLICITLY SET"
      end
    else
      puts "❌ Admin login page: FAILED"
      puts "   Status: #{response.code}"
    end
  rescue => e
    puts "❌ Admin login page: ERROR - #{e.message}"
  end

  puts "\n=== Admin Interface Test Complete ==="
  puts "Login credentials:"
  puts "Email: admin@example.com"
  puts "Password: password"
  puts "\nAdmin interface should be accessible at: #{base_url}/admin"
end

test_admin_interface
