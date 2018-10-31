require 'test_helper'

module Saas
  class ProductsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @product = saas_products(:one)
    end

    test "should get index" do
      get products_url
      assert_response :success
    end

    test "should get new" do
      get new_product_url
      assert_response :success
    end

    test "should create product" do
      assert_difference('Product.count') do
        post products_url, params: { product: { name: @product.name, statement_descriptor: @product.statement_descriptor, stripe_id: @product.stripe_id, unit_label: @product.unit_label } }
      end

      assert_redirected_to product_url(Product.last)
    end

    test "should show product" do
      get product_url(@product)
      assert_response :success
    end

    test "should get edit" do
      get edit_product_url(@product)
      assert_response :success
    end

    test "should update product" do
      patch product_url(@product), params: { product: { name: @product.name, statement_descriptor: @product.statement_descriptor, stripe_id: @product.stripe_id, unit_label: @product.unit_label } }
      assert_redirected_to product_url(@product)
    end

    test "should destroy product" do
      assert_difference('Product.count', -1) do
        delete product_url(@product)
      end

      assert_redirected_to products_url
    end
  end
end
