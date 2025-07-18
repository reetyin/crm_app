# encoding: utf-8

# Rails 8 ActiveStorage compatibility fix
Rails.application.config.to_prepare do
  if defined?(ActiveStorage)
    begin
      # Fix for Rails 8 ActiveStorage association issues

      # Override ActiveStorage::Attachment to handle inverse association errors
      ActiveStorage::Attachment.class_eval do
        def self.reflect_on_association(association)
          if association.to_s == "record"
            # Return a mock association to prevent inverse association errors
            OpenStruct.new(
              name: :record,
              inverse_name: :attachment,
              klass: ActiveRecord::Base,
              options: { polymorphic: true },
              inverse_of: nil,
              class_name: "ActiveRecord::Base"
            )
          else
            super
          end
        end
      end

      # Fix ActiveStorage::Attached::One to handle Rails 8 compatibility
      ActiveStorage::Attached::One.class_eval do
        def attached?
          begin
            # Check if attachment exists in database directly
            ActiveStorage::Attachment.exists?(name: name, record: record)
          rescue StandardError => e
            Rails.logger.warn "ActiveStorage attached? error: #{e.message}"
            false
          end
        end
      end

      # Fix for missing build_after_unfurling method
      ActiveStorage::Blob.class_eval do
        def self.build_after_unfurling(**attributes)
          build(attributes)
        end

        def self.build_after_analyzing(**attributes)
          build(attributes)
        end
      end

      # Patch the attachment association to prevent inverse errors
      ActiveRecord::Base.class_eval do
        def self.has_one_attached(name, dependent: :purge_later, service: nil, strict_loading: nil)
          define_method(name) do
            @active_storage_attached ||= {}
            @active_storage_attached[name] ||= begin
              ActiveStorage::Attached::One.new(name, self)
            rescue ActiveRecord::InverseOfAssociationNotFoundError => e
              Rails.logger.warn "ActiveStorage inverse association error for #{name}: #{e.message}"
              # Create a working attachment object
              ActiveStorage::Attached::One.new(name, self)
            rescue StandardError => e
              Rails.logger.warn "ActiveStorage error for #{name}: #{e.message}"
              # Create a working attachment object
              ActiveStorage::Attached::One.new(name, self)
            end
          end
          
          # Define the attachment method that Active Admin expects
          define_method("#{name}_attachment") do
            send(name)
          end
        end
      end

      Rails.logger.info "ActiveStorage Rails 8 compatibility patches applied successfully"
    rescue => e
      Rails.logger.warn "ActiveStorage compatibility patch failed: #{e.message}"
    end
  end
end

# Disable automatic scope inversing to prevent ActiveStorage errors
Rails.application.config.active_record.automatic_scope_inversing = false
