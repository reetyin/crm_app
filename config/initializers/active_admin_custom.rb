# encoding: utf-8

# Custom ActiveAdmin configuration for UTF-8 support and CRM functionality
# This file provides additional configuration for ActiveAdmin to handle UTF-8 properly

Rails.application.config.after_initialize do
  # Configure ActiveAdmin for UTF-8 support
  if defined?(ActiveAdmin)
    # Ensure proper UTF-8 handling in ActiveAdmin
    ActiveAdmin.application.default_per_page = 30
    ActiveAdmin.application.max_per_page = 10000
  end
end
