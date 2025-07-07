class ActiveStorage::Blob < ApplicationRecord
  self.table_name = "active_storage_blobs"

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "key", "filename", "content_type", "metadata", "service_name", "byte_size", "checksum", "created_at" ]
  end
end
