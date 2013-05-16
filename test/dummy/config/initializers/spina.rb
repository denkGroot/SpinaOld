Spina::Engine.configure do
  yaml_config = YAML.load File.read(File.expand_path("../../spina.yml", __FILE__))

  config.page_part_types = yaml_config['page_part_types']
  config.default_page_parts = yaml_config['page_parts']['default']
  config.page_parts = yaml_config['page_parts']
  config.custom_pages = yaml_config['page_parts'].delete_if { |page_part| page_part == "default" }.keys


  # # Default plugins
  config.NEGATIVE_CAPTCHA_SECRET = 'fee3b3c8b2faa53dafe0978c10c691c29f9c0fdcf12e0052d8c4f5852903707f4a1b6c14f2ac270950b06a287b0683c02a383745025ae6aa3f85091a5deccf06'
  config.plugins = Array.new

  inquiries = Spina::Plugin.new
  inquiries.name = "Contact"
  inquiries.class_name = "Inquiries"
  inquiries.controller = "inquiries"
  inquiries.pictos_icon = "-"


  config.plugins << inquiries
end