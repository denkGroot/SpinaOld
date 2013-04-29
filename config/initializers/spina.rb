config = YAML.load File.read(File.expand_path('../../spina.yml', __FILE__))

Spina.page_part_types = config['page_part_types']
Spina.default_page_parts = config['page_parts']['default']
Spina.page_parts = config['page_parts']
Spina.custom_pages = config['page_parts'].delete_if { |page_part| page_part == "default" }.keys

Spina.plugins = Array.new

# config['plugins'].map do |plugin_name, plugin_config|
#   plugin = Spina::Plugin.new
#   plugin.name = plugin_name
#   plugin.class_name = plugin_config['class_name']
#   plugin.controller = plugin_config['controller']
#   plugin.pictos_icon = plugin_config['pictos_icon']

#   Spina.plugins << plugin
# end
