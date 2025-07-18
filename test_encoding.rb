#!/usr/bin/env ruby
# encoding: utf-8

require 'net/http'
require 'uri'
require 'cgi'

def test_admin_pages
  puts "=== ActiveAdmin 编码测试 ==="

  # Test main pages
  pages = [
    '/admin/login',
    '/customers',
    '/customers/alphabetized',
    '/customers/missing_email'
  ]

  uri = URI('http://localhost:3000')
  http = Net::HTTP.new(uri.host, uri.port)

  pages.each do |page|
    begin
      response = http.get(page)
      body = response.body.force_encoding('UTF-8')

      puts "\n🔍 测试页面: #{page}"
      puts "   状态码: #{response.code}"
      puts "   编码: #{response['content-type']}"

      # Check for Chinese characters
      if body.include?('测试') || body.include?('中文') || body.include?('García')
        puts "   ✅ 包含特殊字符，显示正常"
      else
        puts "   ℹ️  页面不包含测试的特殊字符"
      end

      # Check for encoding issues
      if body.valid_encoding?
        puts "   ✅ UTF-8 编码有效"
      else
        puts "   ❌ UTF-8 编码无效"
      end

    rescue => e
      puts "   ❌ 错误: #{e.message}"
    end
  end

  puts "\n=== 测试完成 ==="
end

test_admin_pages
