env = Rails.env.production? ? :production : :development
rails_config = Rails.application.credentials[env]

if rails_config && rails_config[:stripe]
  Saas.configure do |config|    
    config.stripe_public_key = rails_config[:stripe][:public_key]
    config.stripe_secret_key = rails_config[:stripe][:secret_key]
    config.stripe_signing_secret = rails_config[:stripe][:signing_secret]
  end

  StripeEvent.configure do |events|
    events.subscribe 'charge.succeeded' do |event|
      # TODO: create charge model and save details
      puts "CHARGE SUCCEEDED: #{event}"
    end
  end
end
