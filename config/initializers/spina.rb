config = YAML.load File.read(File.expand_path('../../spina.yml', __FILE__))

Spina.page_part_types = config['page_part_types']
Spina.page_parts = config['page_parts']
Spina.custom_pages = config['page_parts'].map {|key, value| key unless key == 'default' }

Spina.plugins = Array.new