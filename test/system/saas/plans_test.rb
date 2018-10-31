require "application_system_test_case"

module Saas
  class PlansTest < ApplicationSystemTestCase
    setup do
      @plan = saas_plans(:one)
    end

    test "visiting the index" do
      visit plans_url
      assert_selector "h1", text: "Plans"
    end

    test "creating a Plan" do
      visit plans_url
      click_on "New Plan"

      fill_in "Interval", with: @plan.interval
      fill_in "Name", with: @plan.name
      fill_in "Price In Cents", with: @plan.price_in_cents
      fill_in "Saas Product", with: @plan.saas_product_id
      fill_in "Stripe", with: @plan.stripe_id
      fill_in "Trial Period", with: @plan.trial_period
      click_on "Create Plan"

      assert_text "Plan was successfully created"
      click_on "Back"
    end

    test "updating a Plan" do
      visit plans_url
      click_on "Edit", match: :first

      fill_in "Interval", with: @plan.interval
      fill_in "Name", with: @plan.name
      fill_in "Price In Cents", with: @plan.price_in_cents
      fill_in "Saas Product", with: @plan.saas_product_id
      fill_in "Stripe", with: @plan.stripe_id
      fill_in "Trial Period", with: @plan.trial_period
      click_on "Update Plan"

      assert_text "Plan was successfully updated"
      click_on "Back"
    end

    test "destroying a Plan" do
      visit plans_url
      page.accept_confirm do
        click_on "Destroy", match: :first
      end

      assert_text "Plan was successfully destroyed"
    end
  end
end
