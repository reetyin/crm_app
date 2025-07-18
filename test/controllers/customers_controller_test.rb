require "test_helper"

class CustomersControllerTest < ActionDispatch::IntegrationTest
  self.use_transactional_tests = false

  def setup
    # Clean up any existing customers
    Customer.destroy_all

    @customer_with_email = Customer.create!(
      full_name: "John Doe",
      phone_number: "123-456-7890",
      email_address: "john@example.com",
      notes: "Test customer"
    )

    @customer_without_email = Customer.create!(
      full_name: "Jane Smith",
      phone_number: "987-654-3210",
      email_address: "",
      notes: "No email customer"
    )
  end

  def teardown
    Customer.destroy_all
  end

  test "should get index" do
    get root_path
    assert_response :success
    assert_select "h1", "All Customers"
    assert_select ".card", minimum: 1
  end

  test "should get alphabetized view" do
    get customers_alphabetized_path
    assert_response :success
    assert_select "h1", "All Customers"

    # Check that customers are ordered by full_name
    customers = assigns(:customers)
    assert_equal customers.order(:full_name).pluck(:full_name), customers.pluck(:full_name)
  end

  test "should get missing email view" do
    get customers_missing_email_path
    assert_response :success
    assert_select "h1", "All Customers"

    # Check that only customers without email are shown
    customers = assigns(:customers)
    customers.each do |customer|
      assert customer.email_address.blank?, "Customer #{customer.full_name} should not have email"
    end
  end

  test "should have proper navigation links" do
    get root_path
    assert_response :success

    # Check for navigation links
    assert_select "a[href='#{customers_alphabetized_path}']", "Alphabetized View"
    assert_select "a[href='#{customers_missing_email_path}']", "Missing Email View"
  end
end
