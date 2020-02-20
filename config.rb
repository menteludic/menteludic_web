# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

# helpers do
#   def some_helper
#     'Helping'
#   end
# end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

# configure :build do
#   activate :minify_css
#   activate :minify_javascript
# end

configure :development do
  activate :livereload
  activate :sprockets
  # activate :syntax, :line_numbers => true
  activate :directory_indexes

  activate :deploy do |deploy|
    deploy.build_before = true
    deploy.deploy_method = :ftp
    deploy.host = ENV['FTP_HOST']
    deploy.path = '/menteludic.com'
    deploy.user = ENV['FTP_USER']
    deploy.password = ENV['FTP_PASSWORD']
  end
end

# Build-specific configuration
configure :build do
  activate :sprockets
  # Minify CSS on build
  activate :minify_css
  # Minify Javascript on build
  activate :minify_javascript
  # activate :syntax, :line_numbers => true
  activate :directory_indexes
  # activate :search_engine_sitemap
end

activate :google_analytics do |ga|
  ga.tracking_id = ENV['GOOGLE_ANALYTICS_ID']
end
