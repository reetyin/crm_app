# encoding: utf-8

ActiveAdmin.register AdminUser do
  # Define permitted parameters
  permit_params :email, :password, :password_confirmation

  # Configure menu
  menu label: "Admin Users", priority: 2

  # Configure filters
  filter :email, label: "Email"
  filter :created_at, label: "Created At"

  # Configure index page
  index title: "Admin Users" do
    selectable_column
    id_column
    column "Email", :email
    column "Created", :created_at
    column "Updated", :updated_at
    actions
  end

  # Configure form
  form title: "Admin User" do |f|
    f.inputs "Admin User Details" do
      f.input :email, label: "Email Address", hint: "Enter valid email address"
      f.input :password, label: "Password", hint: "Leave blank if not changing"
      f.input :password_confirmation, label: "Confirm Password"
    end
    f.actions
  end

  # Configure show page
  show title: :email do
    attributes_table do
      row "Email" do |admin_user|
        strong admin_user.email
      end
      row "Created At" do |admin_user|
        admin_user.created_at.strftime("%B %d, %Y at %I:%M %p")
      end
      row "Last Updated" do |admin_user|
        admin_user.updated_at.strftime("%B %d, %Y at %I:%M %p")
      end
    end
  end

  # Configure CSV export
  csv do
    column :id
    column :email
    column :created_at
    column :updated_at
  end
end
