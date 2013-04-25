config = YAML.load File.read(File.expand_path('../../spina.yml', __FILE__))

Spina.page_part_types = config['page_part_types']
Spina.default_page_parts = config['page_parts']['default']
Spina.page_parts = config['page_parts']
Spina.custom_pages = config['page_parts'].delete_if { |page_part| page_part == "default" }.keys

Spina.plugins = Array.new