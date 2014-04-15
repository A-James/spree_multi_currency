# encoding: utf-8

Spree::BaseController.class_eval do
  before_filter :set_language_and_currency_based_on_subdomain

  private

    def set_language_and_currency_based_on_subdomain
      req_subdomain = request.subdomain
      subdomain = Spree::Subdomain.find_by_name(req_subdomain)

      if subdomain.nil?
        subdomain = Spree::Subdomain.find_by_name(Spree::Config[:default_subdomain])
      end

      session[:subdomain] = subdomain.name

      # Using the Money gem, we just need to find and store the currency ISO
      currency = supported_currencies.find { |currency| currency.iso_code == subdomain.currency_iso}
      session[:currency] = subdomain.currency_iso

      # And set the locale
      if I18n.available_locales.map(&:to_s).include?(subdomain.locale)
        session[:locale] = I18n.locale = subdomain.locale
      end
    end
end
