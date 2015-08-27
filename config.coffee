app_path = 'app'
app_name = 'myapp'

config =
  app_name: app_name
  app_path: app_path
  web_path: '_public'
  vendor_path: 'vendor'
  assets_path: "#{app_path}/assets"
  app_main_file: 'app.js'
  css_main_file: 'app.css'
  styles_main_file: "#{app_path}/app.sass"
  templates_file: 'app.templates.js'
  templates_module: app_name
  vendor_main_file: 'vendor.js'
  bower_main_js_file: 'bower-vendor.js'
  bower_main_css_file: 'bower-vendor.css'
  manifest_file: 'myapp.appcache'

module.exports = config
