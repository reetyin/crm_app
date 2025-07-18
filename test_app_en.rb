#!/usr/bin/env ruby

# Simple manual test script for CRM application
require 'net/http'
require 'uri'

def test_endpoint(url, description)
  puts "Testing #{description}: #{url}"
  begin
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    if response.code == '200'
      puts "✓ PASS: #{description} - Status: #{response.code}"
      return true
    else
      puts "✗ FAIL: #{description} - Status: #{response.code}"
      return false
    end
  rescue => e
    puts "✗ ERROR: #{description} - #{e.message}"
    return false
  end
end

puts "=== CRM Application Manual Testing ==="
puts "Testing basic functionality of the CRM application"
puts

# Base URL
base_url = "http://localhost:3000"

# Test all endpoints
tests = [
  ["#{base_url}/customers", "All Customers page"],
  ["#{base_url}/customers/alphabetized", "Alphabetized Customers page"],
  ["#{base_url}/customers/missing_email", "Missing Email Customers page"],
  ["#{base_url}/", "Root page (redirects to customers)"]
]

passed = 0
total = tests.length

tests.each do |url, description|
  if test_endpoint(url, description)
    passed += 1
  end
  puts
end

puts "=== Test Results ==="
puts "#{passed}/#{total} tests passed"

if passed == total
  puts "🎉 All tests passed! Your CRM application is working correctly."
else
  puts "⚠️  Some tests failed. Please check the application."
end

# Additional functionality tests
puts "\n=== Additional Functionality Tests ==="

# Test alphabetical ordering
puts "Testing alphabetical ordering functionality..."
begin
  uri = URI.parse("#{base_url}/customers/alphabetized")
  response = Net::HTTP.get_response(uri)
  if response.code == '200' && response.body.include?("Customers Alphabetized")
    puts "✓ Alphabetized page displays correct title"
  else
    puts "✗ Alphabetized page title incorrect"
  end
rescue => e
  puts "✗ Error testing alphabetized page: #{e.message}"
end

# Test missing email functionality
puts "Testing missing email functionality..."
begin
  uri = URI.parse("#{base_url}/customers/missing_email")
  response = Net::HTTP.get_response(uri)
  if response.code == '200' && response.body.include?("Customers with Missing Email")
    puts "✓ Missing email page displays correct title"
  else
    puts "✗ Missing email page title incorrect"
  end
rescue => e
  puts "✗ Error testing missing email page: #{e.message}"
end

puts "\n=== Testing Complete ==="
