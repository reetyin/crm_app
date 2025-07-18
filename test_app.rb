#!/usr/bin/env ruby
# encoding: utf-8

# CRM Application Manual Test Script
puts "=== CRM Application Manual Testing ==="
puts "Testing all pages and functionality..."

require 'net/http'
require 'uri'

def test_page(url, expected_title)
  begin
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    if response.code == '200'
      puts "✓ #{expected_title} - Status: #{response.code}"
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

# Test all pages
tests = [
  [ "http://localhost:3000/", "Root page (redirects to customers)" ],
  [ "http://localhost:3000/customers", "All Customers page" ],
  [ "http://localhost:3000/customers/alphabetized", "Alphabetized Customers page" ],
  [ "http://localhost:3000/customers/missing_email", "Missing Email Customers page" ]
]

passed = 0
total = tests.length

tests.each do |url, title|
  if test_page(url, title)
    passed += 1
  end
end

puts "\n#{passed}/#{total} tests passed"
if passed == total
  puts "🎉 All tests passed! Your CRM application is working correctly."
else
  puts "❌ Some tests failed. Please check the Rails server and routes."
end
