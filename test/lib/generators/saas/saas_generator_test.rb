require 'test_helper'
require 'generators/saas/saas_generator'

module Saas
  class SaasGeneratorTest < Rails::Generators::TestCase
    tests SaasGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
