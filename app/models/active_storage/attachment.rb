class ActiveStorage::Attachment < ApplicationRecord
  self.table_name = "active_storage_attachments"

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "name", "record_type", "record_id", "blob_id", "created_at" ]
  end
end
