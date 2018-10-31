desc "Import Products and Plans from Stripe"
task :sync_stripe => [:environment] do
  stripe_products = Stripe::Product.list
  stripe_products.each do |product|
    local_product = Saas::Product.find_or_create_by(stripe_id: product.id)
    local_product.update(
      name: product.name,
      statement_descriptor: product.statement_descriptor,
      unit_label: product.unit_label,
    )
  end

  stripe_plans = Stripe::Plan.list
  stripe_plans.each do |plan|
    local_plan = Saas::Plan.find_or_create_by(stripe_id: plan.id)
    local_product = Saas::Product.find_by(stripe_id: plan.product)
    local_plan.update(
      product: local_product,
      name: plan.nickname,
      price_in_cents: plan.amount,
      interval: plan.interval,
      trial_period: plan.trial_period_days,
    )
  end
end