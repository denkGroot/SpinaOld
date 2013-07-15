Spina::Engine.configure do

  config.PAGE_TYPES = {
    'default' => [
      { 
        tag: 'header',
        name: 'Headerfoto',
        page_partable_type: 'Spina::Photo',
        position: 0
      }, {
        tag: 'gallery',
        name: 'Fotogalerij',
        page_partable_type: 'Spina::PhotoCollection',
        position: 1
      }, {
        tag: 'file',
        name: 'Super PDF',
        page_partable_type: 'Spina::File',
        position: 2
      }, {
        tag: 'files',
        name: 'Bijlagen',
        page_partable_type: 'Spina::FileCollection',
        position: 3
      }, {
        tag: 'new',
        name: 'Nieuw',
        page_partable_type: 'Text',
        position: 4
      }, {
        tag: 'left',
        name: 'Links',
        page_partable_type: 'Text',
        position: 5
      }, {
        tag: 'right',
        name: 'Rechts',
        page_partable_type: 'Text',
        position: 6
      }
    ],

    'homepage' => [
      {
        tag: 'left_column',
        name: 'Linkerkolom',
        page_partable_type: 'Text',
        position: 0
      }, {
        tag: 'right_column',
        name: 'Rechterkolom',
        page_partable_type: 'Text',
        position: 1
      }
    ],

    'contact' => []
  }
  
  config.default_page_parts = config.PAGE_TYPES['default']
  config.custom_pages = config.PAGE_TYPES.reject { |page_part| page_part == "default" }.keys

  # # Default plugins
  config.NEGATIVE_CAPTCHA_SECRET = 'fee3b3c8b2faa53dafe0978c10c691c29f9c0fdcf12e0052d8c4f5852903707f4a1b6c14f2ac270950b06a287b0683c02a383745025ae6aa3f85091a5deccf06'
  config.plugins = Array.new

  inquiries = Spina::Plugin.new
  inquiries.name = "contact"
  inquiries.class_name = "Inquiry"
  inquiries.controller = "inquiries"
  inquiries.pictos_icon = "M"

  config.plugins << inquiries

end