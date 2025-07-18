# encoding: utf-8

# 修复 Rails 8 中 Active Storage 的 inverse association 问题
Rails.application.config.after_initialize do
  # 为 Active Storage 配置 inverse associations
  if defined?(ActiveStorage)
    begin
      # 设置 Active Storage 的 inverse associations
      ActiveStorage::Attachment.belongs_to :record, polymorphic: true, touch: true
      ActiveStorage::Blob.has_many :attachments, class_name: "ActiveStorage::Attachment", dependent: :destroy
    rescue => e
      Rails.logger.warn "Active Storage inverse association configuration: #{e.message}"
    end
  end
end

# 禁用 Active Record 的 inverse association 检查（临时解决方案）
Rails.application.config.active_record.automatic_scope_inversing = false
