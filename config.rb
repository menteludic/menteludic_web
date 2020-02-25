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
data.events.each do |event_data|
  proxy "/events/#{event_data[:event][:slug]}.html", '/events.html', locals: { event_data: event_data, title: event_data[:event][:name] }

  # event_data[:lists].each do |id, list_data|
  #   proxy(
  #     "/events/#{event_data[:event][:slug]}/#{list_data[:slug]}.html",
  #     '/events/lists.html',
  #     locals: { event_data: event_data, list: list_data }
  #   )
  # end
end

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

helpers do
  def day_name(date)
    ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'][DateTime.parse(date).strftime('%w').to_i]
  end

  def show_date(date)
    "#{day_name(date)} #{DateTime.parse(date).strftime('%e, %H:%M')}"
  end

  def show_hour(date)
    DateTime.parse(date).strftime('%H:%M')
  end
end

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
