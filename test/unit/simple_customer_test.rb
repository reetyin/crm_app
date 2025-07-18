require "test_helper"

class SimpleCustomerTest < ActiveSupport::TestCase
  test "customer is valid with required fields" do
    customer = Customer.new(
      full_name: "John Doe",
      phone_number: "123-456-7890",
      email_address: "john@example.com",
      notes: "Test customer"
    )

    assert customer.valid?
    assert customer.save
  end

  test "customer is invalid without full_name" do
    customer = Customer.new(
      phone_number: "123-456-7890",
      email_address: "john@example.com"
    )

    assert_not customer.valid?
  end

  test "customer is invalid without phone_number" do
    customer = Customer.new(
      full_name: "John Doe",
      email_address: "john@example.com"
    )

    assert_not customer.valid?
  end

  test "customer is valid with blank email" do
    customer = Customer.new(
      full_name: "John Doe",
      phone_number: "123-456-7890",
      email_address: ""
    )

    assert customer.valid?
  end

  test "customer is invalid with bad email format" do
    customer = Customer.new(
      full_name: "John Doe",
      phone_number: "123-456-7890",
      email_address: "bad-email"
    )

    assert_not customer.valid?
  end
end
