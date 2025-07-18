# encoding: utf-8

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_utf8_encoding

  private

  def set_utf8_encoding
    response.headers["Content-Type"] = "text/html; charset=utf-8"
  end
end
