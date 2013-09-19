Spina::Engine.configure do

  config.default_theme = "Business"

  # # Default plugins
  config.NEGATIVE_CAPTCHA_SECRET = 'fee3b3c8b2faa53dafe0978c10c691c29f9c0fdcf12e0052d8c4f5852903707f4a1b6c14f2ac270950b06a287b0683c02a383745025ae6aa3f85091a5deccf06'
  config.plugins = Array.new

  # inquiries = Spina::Plugin.new
  # inquiries.name = "contact"
  # inquiries.class_name = "Spina::Inquiry"
  # inquiries.controller = "inquiries"
  # inquiries.pictos_icon = "z"

  # config.plugins << inquiries

end
