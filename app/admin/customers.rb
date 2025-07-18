# encoding: utf-8

ActiveAdmin.register Customer do
  # Define permitted parameters
  permit_params :full_name, :phone_number, :email_address, :notes, :image

  # Configure menu
  menu label: "Customers", priority: 1

  # Configure filters
  filter :full_name, label: "Full Name"
  filter :phone_number, label: "Phone Number"
  filter :email_address, label: "Email Address"
  filter :notes, label: "Notes"
  filter :created_at, label: "Created At"

  # Configure index page
  index title: "All Customers" do
    selectable_column
    id_column
    column "Avatar", :image do |customer|
      begin
        if customer.image_attached_safely?
          image_tag customer.image, size: "50x50", style: "border-radius: 50%;"
        else
          span "No Image", class: "status_tag"
        end
      rescue
        span "Image Error", class: "status_tag error"
      end
    end
    column "Full Name", :full_name
    column "Phone", :phone_number
    column "Email", :email_address
    column "Notes", :notes do |customer|
      truncate(customer.notes, length: 50) if customer.notes.present?
    end
    column "Created", :created_at
    actions
  end

  # Configure form
  form title: "Customer" do |f|
    f.inputs "Customer Details" do
      f.input :full_name, label: "Full Name", hint: "Enter customer's full name"
      f.input :phone_number, label: "Phone Number", hint: "Enter phone number (e.g., 123-456-7890)"
      f.input :email_address, label: "Email Address", hint: "Enter valid email address"
      f.input :notes, label: "Notes", as: :text, hint: "Additional notes about the customer"

      # Custom image upload field to work around Rails 8 compatibility issues
      f.li do
        label "Profile Image"
        if f.object.image_attached_safely?
          div style: "margin-bottom: 10px;" do
            image_tag f.object.image, size: "100x100", style: "border-radius: 8px; border: 2px solid #e5e7eb;"
          end
        end
        raw '<input type="file" name="customer[image]" accept="image/*" style="margin-top: 5px;">'
        para "Upload a new image to replace the current one (if any).", style: "color: #6b7280; font-size: 0.875rem; margin-top: 5px;"
      end
    end
    f.actions
  end

  # Configure show page
  show title: :full_name do
    attributes_table do
      row "Profile Image" do |customer|
        begin
          if customer.image_attached_safely?
            image_tag customer.image, size: "150x150", style: "border-radius: 10px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);"
          else
            span "No profile image uploaded", class: "status_tag"
          end
        rescue
          span "Image Error - Please re-upload", class: "status_tag error"
        end
      end
      row "Full Name" do |customer|
        strong customer.full_name
      end
      row "Phone Number" do |customer|
        customer.phone_number
      end
      row "Email Address" do |customer|
        if customer.email_address.present?
          mail_to customer.email_address
        else
          span "No email provided", class: "empty"
        end
      end
      row "Notes" do |customer|
        simple_format(customer.notes) if customer.notes.present?
      end
      row "Created At" do |customer|
        customer.created_at.strftime("%B %d, %Y at %I:%M %p")
      end
      row "Last Updated" do |customer|
        customer.updated_at.strftime("%B %d, %Y at %I:%M %p")
      end
    end
  end

  # Configure CSV export
  csv do
    column :id
    column :full_name
    column :phone_number
    column :email_address
    column :notes
    column :created_at
    column :updated_at
  end
end
