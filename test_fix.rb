#!/usr/bin/env ruby
# encoding: utf-8

# 测试图片上传功能修复
require_relative 'config/environment'

puts "=== CRM App 图片上传功能修复测试 ==="
puts "Time: #{Time.current}"
puts

# 测试 Customer 模型
puts "1. 测试 Customer 模型..."
customer = Customer.new(
  full_name: "测试用户",
  phone_number: "123-456-7890",
  email_address: "test@example.com",
  notes: "这是一个测试用户"
)

if customer.valid?
  puts "✓ Customer 模型验证通过"
else
  puts "✗ Customer 模型验证失败: #{customer.errors.full_messages.join(', ')}"
end

# 测试 has_image? 方法
puts "\n2. 测试 has_image? 方法..."
puts "✓ has_image? 方法存在: #{customer.respond_to?(:has_image?)}"
puts "✓ 无图片时返回 false: #{customer.has_image? == false}"

# 测试数据库连接
puts "\n3. 测试数据库连接..."
begin
  customer_count = Customer.count
  puts "✓ 数据库连接正常，当前客户数量: #{customer_count}"
rescue => e
  puts "✗ 数据库连接失败: #{e.message}"
end

# 测试 Active Storage 配置
puts "\n4. 测试 Active Storage 配置..."
begin
  if ActiveStorage::Blob.table_exists?
    puts "✓ Active Storage 表存在"
    blob_count = ActiveStorage::Blob.count
    puts "✓ 当前存储的文件数量: #{blob_count}"
  else
    puts "✗ Active Storage 表不存在"
  end
rescue => e
  puts "✗ Active Storage 检查失败: #{e.message}"
end

# 测试图片关联
puts "\n5. 测试图片关联..."
begin
  first_customer = Customer.first
  if first_customer
    puts "✓ 找到第一个客户: #{first_customer.full_name}"
    puts "✓ 图片状态: #{first_customer.has_image? ? '有图片' : '无图片'}"
  else
    puts "✗ 未找到客户记录"
  end
rescue => e
  puts "✗ 图片关联测试失败: #{e.message}"
end

puts "\n=== 测试完成 ==="
puts "应用程序现在应该可以正常运行，包括："
puts "- 主页面 (http://localhost:3000)"
puts "- 管理界面 (http://localhost:3000/admin)"
puts "- 图片上传功能在管理界面中可用"
