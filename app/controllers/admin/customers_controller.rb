# encoding: utf-8

class Admin::CustomersController < ActiveAdmin::ResourceController
  def update
    @customer = Customer.find(params[:id])
    
    # Handle image upload manually
    if params[:customer][:image].present?
      uploaded_file = params[:customer][:image]
      
      # Create a temporary file
      temp_file = Tempfile.new(['upload', File.extname(uploaded_file.original_filename)])
      temp_file.binmode
      temp_file.write(uploaded_file.read)
      temp_file.rewind
      
      # Use our custom upload method
      success = @customer.upload_image_from_file(temp_file.path, uploaded_file.original_filename)
      
      # Clean up temp file
      temp_file.close
      temp_file.unlink
      
      unless success
        flash[:error] = "Failed to upload image"
        redirect_to edit_admin_customer_path(@customer) and return
      end
    end
    
    # Update other attributes
    if @customer.update(customer_params_without_image)
      redirect_to admin_customer_path(@customer), notice: 'Customer was successfully updated.'
    else
      render :edit
    end
  end
  
  private
  
  def customer_params_without_image
    params.require(:customer).permit(:full_name, :phone_number, :email_address, :notes)
  end
end 