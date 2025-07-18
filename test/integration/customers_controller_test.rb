require "test_helper"

class CustomersControllerTest < ActionDispatch::IntegrationTest
  def setup
    # 清理测试数据
    Customer.destroy_all

    # 创建测试数据
    @customer1 = Customer.create!(
      full_name: "Alice Johnson",
      phone_number: "123-456-7890",
      email_address: "alice@example.com"
    )

    @customer2 = Customer.create!(
      full_name: "Bob Smith",
      phone_number: "098-765-4321",
      email_address: ""
    )

    @customer3 = Customer.create!(
      full_name: "Charlie Brown",
      phone_number: "555-123-4567",
      email_address: nil
    )
  end

  def teardown
    Customer.destroy_all
  end

  def test_should_get_index
    get customers_path
    assert_response :success
    assert_select "h1", "All Customers"
  end

  def test_should_get_alphabetized
    get alphabetized_customers_path
    assert_response :success
    assert_select "h1", "Customers Alphabetized"
  end

  def test_should_get_missing_email
    get missing_email_customers_path
    assert_response :success
    assert_select "h1", "Customers with Missing Email"
  end

  def test_index_displays_all_customers
    get customers_path
    assert_response :success
    assert_select ".customer-card", count: 3
    assert_select '.customer-card:contains("Alice Johnson")', count: 1
    assert_select '.customer-card:contains("Bob Smith")', count: 1
    assert_select '.customer-card:contains("Charlie Brown")', count: 1
  end

  def test_alphabetized_shows_customers_in_order
    get alphabetized_customers_path
    assert_response :success
    assert_select ".customer-card", count: 3

    # 验证按字母顺序排列
    response_body = response.body
    alice_pos = response_body.index("Alice Johnson")
    bob_pos = response_body.index("Bob Smith")
    charlie_pos = response_body.index("Charlie Brown")

    assert alice_pos < bob_pos
    assert bob_pos < charlie_pos
  end

  def test_missing_email_shows_only_customers_without_email
    get missing_email_customers_path
    assert_response :success
    assert_select ".customer-card", count: 2
    assert_select '.customer-card:contains("Bob Smith")', count: 1
    assert_select '.customer-card:contains("Charlie Brown")', count: 1
    assert_select '.customer-card:contains("Alice Johnson")', count: 0
  end

  def test_navigation_links_present
    get customers_path
    assert_response :success

    # 验证导航链接存在
    assert_select "a[href=?]", customers_path
    assert_select "a[href=?]", alphabetized_customers_path
    assert_select "a[href=?]", missing_email_customers_path
  end
end
