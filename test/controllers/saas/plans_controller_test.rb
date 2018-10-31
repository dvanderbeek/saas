require 'test_helper'

module Saas
  class PlansControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @plan = saas_plans(:one)
    end

    test "should get index" do
      get plans_url
      assert_response :success
    end

    test "should get new" do
      get new_plan_url
      assert_response :success
    end

    test "should create plan" do
      assert_difference('Plan.count') do
        post plans_url, params: { plan: { interval: @plan.interval, name: @plan.name, price_in_cents: @plan.price_in_cents, saas_product_id: @plan.saas_product_id, stripe_id: @plan.stripe_id, trial_period: @plan.trial_period } }
      end

      assert_redirected_to plan_url(Plan.last)
    end

    test "should show plan" do
      get plan_url(@plan)
      assert_response :success
    end

    test "should get edit" do
      get edit_plan_url(@plan)
      assert_response :success
    end

    test "should update plan" do
      patch plan_url(@plan), params: { plan: { interval: @plan.interval, name: @plan.name, price_in_cents: @plan.price_in_cents, saas_product_id: @plan.saas_product_id, stripe_id: @plan.stripe_id, trial_period: @plan.trial_period } }
      assert_redirected_to plan_url(@plan)
    end

    test "should destroy plan" do
      assert_difference('Plan.count', -1) do
        delete plan_url(@plan)
      end

      assert_redirected_to plans_url
    end
  end
end
