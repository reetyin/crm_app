require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]
end

class CrmAppSystemTest < ApplicationSystemTestCase
  def setup
    # Clean up any existing customers
    Customer.destroy_all

    # Create test customers
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

  test "visiting the index" do
    visit "/"

    assert_selector "h1", text: "All Customers"
    assert_selector ".card", count: 2
    assert_text "John Doe"
    assert_text "Jane Smith"
  end

  test "alphabetized view" do
    visit "/customers/alphabetized"

    assert_selector "h1", text: "All Customers"
    assert_selector ".card", count: 2

    # Check order (Jane should come before John)
    cards = all(".card .title")
    assert_equal "Jane Smith", cards[0].text
    assert_equal "John Doe", cards[1].text
  end

  test "missing email view" do
    visit "/customers/missing_email"

    assert_selector "h1", text: "All Customers"
    assert_selector ".card", count: 1
    assert_text "Jane Smith"
    assert_no_text "John Doe"
  end

  test "navigation links" do
    visit "/"

    assert_link "Alphabetized View"
    assert_link "Missing Email View"

    click_link "Alphabetized View"
    assert_current_path "/customers/alphabetized"

    click_link "Missing Email View"
    assert_current_path "/customers/missing_email"
  end
end
