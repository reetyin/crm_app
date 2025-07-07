ActiveAdmin.register Customer do
  permit_params :full_name, :phone_number, :email_address, :notes, :image

  index do
    selectable_column
    id_column
    column :full_name
    column :phone_number
    column :email_address
    column :notes
    column :image do |customer|
      image_tag customer.image if customer.image.attached?
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :full_name
      f.input :phone_number
      f.input :email_address
      f.input :notes
      f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :full_name
      row :phone_number
      row :email_address
      row :notes
      row :image do |customer|
        image_tag customer.image if customer.image.attached?
      end
    end
  end
end