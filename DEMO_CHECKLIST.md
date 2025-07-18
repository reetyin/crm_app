# 🎯 演示检查清单

## 演示前准备 ✅

### 技术准备
- [ ] Rails 服务器已启动 (http://localhost:3000)
- [ ] 浏览器已打开并测试所有页面
- [ ] 代码编辑器已打开关键文件
- [ ] 网络连接稳定（Bulma CDN）

### 文件准备
- [ ] `app/views/customers/_customer.html.erb` (PART 1)
- [ ] `app/controllers/customers_controller.rb` (PART 2)
- [ ] `config/routes.rb` (PART 2)
- [ ] `app/views/layouts/application.html.erb` (PART 3)

### 数据准备
- [ ] 确认有客户数据（至少9个客户）
- [ ] 确认有些客户没有邮箱（至少4个）
- [ ] 确认至少有一个客户有头像图片

## 演示步骤快速指南

### 🔥 核心演示流程（15分钟）

#### 1. 项目概述 (2分钟)
- 介绍技术栈：Rails 8.0.2, Ruby 3.2.2, Bulma CSS
- 说明项目目标：CRM 客户管理系统

#### 2. PART 1 - 客户部分视图 (4分钟)
- 🌐 访问：http://localhost:3000
- 📋 展示：客户卡片布局，图片显示
- 💻 代码：`app/views/customers/_customer.html.erb`
- 🎯 重点：image_tag 助手的使用

#### 3. PART 2 - 控制器动作 (5分钟)
- 🌐 访问：http://localhost:3000/customers/alphabetized
- 🌐 访问：http://localhost:3000/customers/missing_email
- 📋 展示：三个不同的数据视图
- 💻 代码：`app/controllers/customers_controller.rb`
- 🎯 重点：三个动作的实现

#### 4. PART 3 - CSS 样式 (2分钟)
- 💻 代码：`app/views/layouts/application.html.erb`
- 📋 展示：Bulma CDN 链接
- 🎯 重点：响应式设计效果

#### 5. 额外功能 (2分钟)
- 🌐 访问：http://localhost:3000/admin
- 👤 登录：admin@example.com / password
- 📋 展示：后台管理功能

## 🎤 关键说明词

### 开场白
"今天我将演示一个完整的 Rails CRM 项目，它完全满足了作业的所有要求。"

### PART 1 说明
"这是客户部分视图，使用了 image_tag 助手来显示客户图片，并采用 Bulma CSS 框架进行样式设计。"

### PART 2 说明
"我创建了包含三个动作的 CustomersController，每个动作都有对应的视图和路由配置。"

### PART 3 说明
"项目使用 Bulma CSS 框架，通过 CDN 加载，实现了现代化的响应式设计。"

### 结束语
"这个项目展示了完整的 Rails MVC 架构应用，满足了所有作业要求并添加了实用的额外功能。"

## 🚨 常见问题准备

### Q: 为什么选择 Bulma CSS？
A: Bulma 是现代化的 CSS 框架，语法简洁，响应式设计优秀，适合快速开发。

### Q: 图片上传是如何实现的？
A: 使用 Rails 的 ActiveStorage 功能，在后台管理界面可以上传客户头像。

### Q: 如何确保数据验证？
A: 在 Customer 模型中添加了验证规则，确保姓名和电话必填，邮箱格式正确。

### Q: 为什么使用 ActiveAdmin？
A: ActiveAdmin 提供了完整的后台管理功能，可以快速构建管理界面。

## ⏰ 时间提醒
- 总时间控制在 15-20 分钟
- 每个部分不要超过预定时间
- 留出 2-3 分钟回答问题

## 🎯 成功标准
- [ ] 所有页面都能正常访问
- [ ] 所有功能都能正常演示
- [ ] 代码清晰易懂
- [ ] 满足所有作业要求
- [ ] 额外功能加分项展示完整
