# 🎯 演示脚本 - 简化版

## 演示时间：15分钟

### 1. 开场白 (1分钟)
"今天我将演示一个完整的 Rails CRM 项目。使用 Rails 8.0.2 和 Ruby 3.2.2 开发，完全满足作业的三个部分要求。"

### 2. PART 1 - 客户部分视图 (4分钟)
- 🌐 打开：http://localhost:3000
- 📋 展示：客户卡片布局，图片显示
- 💻 代码：`app/views/customers/_customer.html.erb`
- 🎯 说明：image_tag 助手的使用

"这是客户部分视图，使用 image_tag 助手显示客户图片。有图片显示实际图片，无图片显示占位符。"

### 3. PART 2 - 控制器动作 (5分钟)
- 🌐 演示三个页面：
  - http://localhost:3000 (所有客户)
  - http://localhost:3000/customers/alphabetized (字母排序)
  - http://localhost:3000/customers/missing_email (缺少邮箱)
- 💻 代码：`app/controllers/customers_controller.rb`
- 🎯 说明：三个动作的不同查询逻辑

"我创建了包含三个动作的控制器，每个动作都有不同的数据查询和对应的视图。"

### 4. PART 3 - CSS 样式 (2分钟)
- 💻 代码：`app/views/layouts/application.html.erb`
- 📋 展示：Bulma CDN 链接
- 🎯 说明：响应式设计效果

"使用 Bulma CSS 框架，通过 CDN 加载，实现现代化的响应式设计。"

### 5. 额外功能 (2分钟)
- 🌐 访问：http://localhost:3000/admin
- 👤 登录：admin@example.com / password
- 📋 展示：后台管理功能

"除了作业要求，我还添加了完整的后台管理系统。"

### 6. 总结 (1分钟)
"这个项目完全满足了作业的所有要求：
- PART 1: 使用 image_tag 助手的客户部分视图 ✅
- PART 2: 三个控制器动作和对应视图 ✅
- PART 3: 使用 Bulma CSS 框架进行样式设计 ✅
并且添加了实用的后台管理功能。"

## 🚨 注意事项

### 演示前检查
- [ ] 服务器正在运行
- [ ] 所有页面都能正常访问
- [ ] 代码文件已打开
- [ ] 浏览器已准备好

### 演示要点
- 强调每个 PART 的具体要求
- 展示代码和页面效果的对应关系
- 突出技术实现的亮点
- 保持演示流畅性

### 可能的问题
- 如果页面加载慢，说明是 CDN 加载 Bulma CSS
- 如果图片不显示，说明是占位符功能
- 如果后台登录失败，重新输入凭据

## 🎯 成功标准
- 所有作业要求都得到清晰展示
- 技术实现得到充分说明
- 额外功能体现了深入理解
- 演示流畅专业
