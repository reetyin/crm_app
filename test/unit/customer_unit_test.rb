require 'test_helper'

class CustomerUnitTest < Minitest::Test
  def setup
    # Use Rails test environment but don't load fixtures
    Rails.application.load_tasks
  end

  def teardown
    # Clean up test data
    Customer.destroy_all
  end

  def test_customer_is_valid_with_required_fields
    customer = Customer.new(
      full_name: "John Doe",
      phone_number: "123-456-7890",
      email_address: "john@example.com"
    )
    assert customer.valid?
  end

  def test_customer_is_invalid_without_full_name
    customer = Customer.new(
      phone_number: "123-456-7890",
      email_address: "john@example.com"
    )
    refute customer.valid?
    assert customer.errors.key?(:full_name)
  end

  def test_customer_is_invalid_without_phone_number
    customer = Customer.new(
      full_name: "John Doe",
      email_address: "john@example.com"
    )
    refute customer.valid?
    assert customer.errors.key?(:phone_number)
  end

  def test_customer_is_valid_with_blank_email
    customer = Customer.new(
      full_name: "John Doe",
      phone_number: "123-456-7890",
      email_address: ""
    )
    assert customer.valid?
  end

  def test_customer_is_invalid_with_bad_email_format
    customer = Customer.new(
      full_name: "John Doe",
      phone_number: "123-456-7890",
      email_address: "invalid-email"
    )
    refute customer.valid?
    assert customer.errors.key?(:email_address)
  end

  def test_customer_is_valid_with_good_email_format
    customer = Customer.new(
      full_name: "John Doe",
      phone_number: "123-456-7890",
      email_address: "test@example.com"
    )
    assert customer.valid?
  end

  def test_customer_ransack_attributes
    # Test ransack searchable attributes
    assert Customer.ransackable_attributes.include?("full_name")
    assert Customer.ransackable_attributes.include?("phone_number")
    assert Customer.ransackable_attributes.include?("email_address")
  end
end
