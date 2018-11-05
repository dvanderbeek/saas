module Saas
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    desc "Copies the initilizer for the saas gem"

    def copy_initializer_file
      copy_file 'saas.rb', 'config/initializers/saas.rb'
    end
  end
end