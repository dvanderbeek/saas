require "application_system_test_case"

module Saas
  class ProductsTest < ApplicationSystemTestCase
    setup do
      @product = saas_products(:one)
    end

    test "visiting the index" do
      visit products_url
      assert_selector "h1", text: "Products"
    end

    test "creating a Product" do
      visit products_url
      click_on "New Product"

      fill_in "Name", with: @product.name
      fill_in "Statement Descriptor", with: @product.statement_descriptor
      fill_in "Stripe", with: @product.stripe_id
      fill_in "Unit Label", with: @product.unit_label
      click_on "Create Product"

      assert_text "Product was successfully created"
      click_on "Back"
    end

    test "updating a Product" do
      visit products_url
      click_on "Edit", match: :first

      fill_in "Name", with: @product.name
      fill_in "Statement Descriptor", with: @product.statement_descriptor
      fill_in "Stripe", with: @product.stripe_id
      fill_in "Unit Label", with: @product.unit_label
      click_on "Update Product"

      assert_text "Product was successfully updated"
      click_on "Back"
    end

    test "destroying a Product" do
      visit products_url
      page.accept_confirm do
        click_on "Destroy", match: :first
      end

      assert_text "Product was successfully destroyed"
    end
  end
end
