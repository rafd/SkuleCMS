if RAILS_ENV == "development"
	require 'compass'
	# If you have any compass plugins, require them here.
	Compass.configuration.parse(File.join(RAILS_ROOT, "config", "compass.config"))
	Compass.configuration.environment = RAILS_ENV.to_sym
	Sass::Plugin.options[:never_update] = true
	Compass.configure_sass_plugin!
end
