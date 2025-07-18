# encoding: utf-8

class Customer < ApplicationRecord
  has_one_attached :image

  validates :full_name, presence: true
  validates :phone_number, presence: true
  validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true

  # Safe method to check if image is attached (Rails 8 compatibility)
  def image_attached_safely?
    begin
      image.attached?
    rescue ActiveRecord::InverseOfAssociationNotFoundError
      false
    rescue StandardError
      false
    end
  end

  # Safe method to get image URL (Rails 8 compatibility)
  def safe_image_url
    begin
      return nil unless image.attached?
      Rails.application.routes.url_helpers.url_for(image)
    rescue ActiveRecord::InverseOfAssociationNotFoundError
      nil
    rescue StandardError
      nil
    end
  end

  # Manual image upload method for Rails 8 compatibility
  def upload_image_from_file(file_path, filename = nil)
    begin
      # Create blob manually
      blob = ActiveStorage::Blob.create!(
        key: SecureRandom.uuid,
        filename: filename || File.basename(file_path),
        content_type: 'image/jpeg',
        service_name: 'local',
        byte_size: File.size(file_path)
      )

      # Copy file to storage location manually
      storage_path = Rails.root.join('storage', blob.key)
      FileUtils.mkdir_p(File.dirname(storage_path))
      FileUtils.cp(file_path, storage_path)

      # Create attachment manually
      ActiveStorage::Attachment.create!(
        name: 'image',
        record_type: 'Customer',
        record_id: self.id,
        blob_id: blob.id
      )

      # Clear cached instance
      @active_storage_attached = nil if defined?(@active_storage_attached)

      true
    rescue => e
      Rails.logger.error "Image upload failed: #{e.message}"
      Rails.logger.error e.backtrace.first(5)
      false
    end
  end

  # Allowlist associations for Ransack (ActiveAdmin filtering)
  def self.ransackable_associations(auth_object = nil)
    []
  end

  # Allowlist attributes for Ransack (ActiveAdmin filtering)
  def self.ransackable_attributes(auth_object = nil)
    [ "id", "full_name", "phone_number", "email_address", "notes", "created_at", "updated_at" ]
  end
end
