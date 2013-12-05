# encoding: utf-8

module Spree
  class Subdomain < ActiveRecord::Base

    def self.allow_params(request_params)
      parameters = ActionController::Parameters.new(request_params)
      parameters.permit(
        :name, :locale, :country_iso, :currency_num_code, :description
      )
    end

    def self.current(session_subdomain)
      str = session_subdomain.present? ? session_subdomain : Spree::Config[:default_subdomain]
      where(name: str).first
    end
  end
end
