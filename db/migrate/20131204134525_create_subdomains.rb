class CreateSubdomains < ActiveRecord::Migration
  def change
    create_table :spree_subdomains do |t|
      t.string :name
      t.string :description
      t.string :locale
      t.string :country_iso
      t.string :currency_iso
    end

    Spree::Subdomain.create(
      name: "uk",
      description: "United Kingdom",
      locale: "en-GB",
      country_iso: "GB",
      currency_iso: "GBP"
      )
  end
end
