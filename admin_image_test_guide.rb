#!/usr/bin/env ruby
# encoding: utf-8

# CRM Admin Image Upload Test Guide
puts "=== CRM Admin Image Upload功能测试指南 ==="
puts "按照以下步骤测试图片上传功能：\n"

puts "1. 访问管理员登录页面："
puts "   http://localhost:3000/admin/login"
puts ""

puts "2. 使用以下凭据登录："
puts "   Email: admin@example.com"
puts "   Password: password"
puts ""

puts "3. 登录后，点击左侧菜单中的 'Customers'"
puts "   或直接访问: http://localhost:3000/admin/customers"
puts ""

puts "4. 测试图片上传功能："
puts "   a) 点击 'New Customer' 按钮创建新客户"
puts "   b) 填写客户信息（姓名和电话是必填项）"
puts "   c) 在 'Profile Image' 字段选择图片文件"
puts "   d) 点击 'Create Customer' 保存"
puts ""

puts "5. 测试图片显示功能："
puts "   a) 在客户列表中查看Avatar列"
puts "   b) 点击客户姓名查看详情页"
puts "   c) 在详情页查看大尺寸头像"
puts ""

puts "6. 测试编辑功能："
puts "   a) 点击 'Edit' 按钮编辑客户"
puts "   b) 更换客户头像"
puts "   c) 保存更改"
puts ""

puts "7. 测试前端显示："
puts "   a) 访问 http://localhost:3000"
puts "   b) 查看客户卡片中的头像显示"
puts "   c) 测试不同页面的显示效果"
puts ""

puts "功能特点："
puts "✓ 在Admin管理页面上传客户头像"
puts "✓ 在客户列表中显示小尺寸头像"
puts "✓ 在客户详情页显示大尺寸头像"
puts "✓ 在前端客户页面使用image_tag helper显示头像"
puts "✓ 错误处理：如果图片有问题，显示警告图标"
puts "✓ 无图片时显示默认用户图标"
puts ""

puts "注意事项："
puts "- 支持的图片格式：JPG, PNG, GIF"
puts "- 图片会自动调整大小和裁剪"
puts "- 使用Rails 8兼容的ActiveStorage配置"
puts "- 包含完整的错误处理机制"
puts ""

puts "开始测试吧！🚀"
