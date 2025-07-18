#!/usr/bin/env ruby
# Test admin login and access

require 'net/http'
require 'uri'
require 'json'

def test_admin_login_flow
  puts "=== Testing Admin Login Flow ==="

  # Step 1: Access admin login page
  puts "\n1. Accessing admin login page..."
  login_uri = URI('http://localhost:3000/admin/login')
  http = Net::HTTP.new(login_uri.host, login_uri.port)

  response = http.get(login_uri.path)
  if response.code == '200'
    puts "✅ Login page accessible"

    # Extract CSRF token
    csrf_token = response.body.match(/name="authenticity_token" value="([^"]+)"/)[1] rescue nil
    if csrf_token
      puts "✅ CSRF token extracted: #{csrf_token[0..20]}..."
    else
      puts "❌ Could not extract CSRF token"
      return
    end

    # Extract cookies
    cookies = response.get_fields('set-cookie')
    session_cookie = cookies.find { |c| c.include?('_crm_app_session') } if cookies

    if session_cookie
      puts "✅ Session cookie obtained"
    else
      puts "❌ No session cookie found"
      return
    end

    # Step 2: Attempt login
    puts "\n2. Attempting login with admin credentials..."

    login_data = "admin_user[email]=admin@example.com&admin_user[password]=password&authenticity_token=#{csrf_token}&commit=Login"

    headers = {
      'Content-Type' => 'application/x-www-form-urlencoded',
      'Cookie' => session_cookie.split(';')[0]
    }

    login_response = http.post(login_uri.path, login_data, headers)

    if login_response.code == '302'
      location = login_response['location']
      puts "✅ Login successful - redirecting to: #{location}"

      # Step 3: Test access to admin customers
      puts "\n3. Testing access to admin customers page..."

      # Extract new session cookie after login
      new_cookies = login_response.get_fields('set-cookie')
      new_session_cookie = new_cookies.find { |c| c.include?('_crm_app_session') } if new_cookies

      if new_session_cookie
        customer_headers = {
          'Cookie' => new_session_cookie.split(';')[0]
        }

        customer_response = http.get('/admin/customers', customer_headers)

        if customer_response.code == '200'
          puts "✅ Admin customers page accessible after login"
        elsif customer_response.code == '302'
          puts "❌ Still redirecting - login may have failed"
          puts "   Redirect to: #{customer_response['location']}"
        else
          puts "❌ Unexpected response: #{customer_response.code}"
        end
      else
        puts "❌ No new session cookie after login"
      end
    else
      puts "❌ Login failed - response code: #{login_response.code}"
    end
  else
    puts "❌ Login page not accessible - response code: #{response.code}"
  end

  puts "\n=== Instructions ==="
  puts "To access the admin interface:"
  puts "1. Go to: http://localhost:3000/admin"
  puts "2. Login with:"
  puts "   Email: admin@example.com"
  puts "   Password: password"
  puts "3. Then you can access: http://localhost:3000/admin/customers"
end

test_admin_login_flow
