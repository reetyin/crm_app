require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  self.use_transactional_tests = false

  def teardown
    Customer.destroy_all
  end

  test "should be valid with valid attributes" do
    customer = Customer.new(
      full_name: "John Doe",
      phone_number: "123-456-7890",
      email_address: "john@example.com",
      notes: "Test customer"
    )
    assert customer.valid?
  end

  test "should not be valid without full_name" do
    customer = Customer.new(
      phone_number: "123-456-7890",
      email_address: "john@example.com"
    )
    assert_not customer.valid?
    assert_includes customer.errors[:full_name], "can't be blank"
  end

  test "should not be valid without phone_number" do
    customer = Customer.new(
      full_name: "John Doe",
      email_address: "john@example.com"
    )
    assert_not customer.valid?
    assert_includes customer.errors[:phone_number], "can't be blank"
  end

  test "should be valid with blank email_address" do
    customer = Customer.new(
      full_name: "John Doe",
      phone_number: "123-456-7890",
      email_address: ""
    )
    assert customer.valid?
  end

  test "should not be valid with invalid email format" do
    customer = Customer.new(
      full_name: "John Doe",
      phone_number: "123-456-7890",
      email_address: "invalid-email"
    )
    assert_not customer.valid?
    assert_includes customer.errors[:email_address], "is invalid"
  end

  test "should be valid with valid email format" do
    customer = Customer.new(
      full_name: "John Doe",
      phone_number: "123-456-7890",
      email_address: "john@example.com"
    )
    assert customer.valid?
  end

  test "should have ransackable associations" do
    expected_associations = [ "image_attachment", "image_blob" ]
    assert_equal expected_associations, Customer.ransackable_associations
  end

  test "should have ransackable attributes" do
    expected_attributes = [ "id", "full_name", "phone_number", "email_address", "notes", "created_at", "updated_at" ]
    assert_equal expected_attributes, Customer.ransackable_attributes
  end
end
