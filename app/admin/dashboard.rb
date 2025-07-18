# encoding: utf-8

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Dashboard sections
    columns do
      column do
        panel "Recent Customers" do
          ul do
            Customer.order(created_at: :desc).limit(5).each do |customer|
              li link_to(customer.full_name, admin_customer_path(customer))
            end
          end
        end
      end

      column do
        panel "Statistics" do
          para "Total Customers: #{Customer.count}"
          para "Customers with Email: #{Customer.where.not(email_address: [ nil, '' ]).count}"
          para "Customers without Email: #{Customer.where(email_address: [ nil, '' ]).count}"
          para "Total Admin Users: #{AdminUser.count}"
        end
      end
    end

    columns do
      column do
        panel "Recent Activity" do
          para "Recent customers created:"
          ul do
            Customer.order(created_at: :desc).limit(3).each do |customer|
              li "#{customer.full_name} - #{time_ago_in_words(customer.created_at)} ago"
            end
          end
        end
      end

      column do
        panel "Quick Actions" do
          para link_to("View All Customers", admin_customers_path, class: "button")
          para link_to("Add New Customer", new_admin_customer_path, class: "button")
          para link_to("Manage Admin Users", admin_admin_users_path, class: "button")
        end
      end
    end
  end
end
