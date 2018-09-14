# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( lib/bootstrap/dist/css/bootstrap.min )
Rails.application.config.assets.precompile += %w( lib/animate.css/animate )
Rails.application.config.assets.precompile += %w( lib/components-font-awesome/css/font-awesome.min )
Rails.application.config.assets.precompile += %w( lib/et-line-font/et-line-font )
Rails.application.config.assets.precompile += %w( lib/flexslider/flexslider )
Rails.application.config.assets.precompile += %w( lib/owl.carousel/dist/assets/owl.carousel.min )
Rails.application.config.assets.precompile += %w( lib/owl.carousel/dist/assets/owl.theme.default.min )
Rails.application.config.assets.precompile += %w( lib/magnific-popup/dist/magnific-popup )
Rails.application.config.assets.precompile += %w( lib/simple-text-rotator/simpletextrotator )
Rails.application.config.assets.precompile += %w( css/style )
Rails.application.config.assets.precompile += %w( css/colors/default )
