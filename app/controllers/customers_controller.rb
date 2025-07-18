# encoding: utf-8

class CustomersController < ApplicationController
  before_action :set_customer, only: [ :show, :edit, :update ]

  def index
    @customers = Customer.all
  end

  def show
  end

  def alphabetized
    @customers = Customer.order(:full_name)
  end

  def missing_email
    @customers = Customer.where(email_address: [ nil, "" ])
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: "Customer was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:full_name, :phone_number, :email_address, :notes)
  end
end
