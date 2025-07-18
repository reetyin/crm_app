#!/usr/bin/env ruby

# 简单的手动测试脚本
require 'net/http'
require 'uri'

def test_endpoint(url, description)
  puts "Testing #{description}: #{url}"
  begin
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    if response.code == '200'
      puts "✓ PASS: #{description} - Status: #{response.code}"
      true
    else
      puts "✗ FAIL: #{description} - Status: #{response.code}"
      false
    end
  rescue => e
    puts "✗ ERROR: #{description} - #{e.message}"
    false
  end
end

puts "=== CRM App Manual Testing ==="
puts "Testing basic functionality of the CRM application"
puts

# 基本URL
base_url = "http://localhost:3000"

# 测试所有端点
tests = [
  [ "#{base_url}/customers", "All Customers page" ],
  [ "#{base_url}/customers/alphabetized", "Alphabetized Customers page" ],
  [ "#{base_url}/customers/missing_email", "Missing Email Customers page" ],
  [ "#{base_url}/", "Root page (redirects to customers)" ]
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
