Spina::Engine.configure do

  config.PAGE_TYPES = {
    'default' => [
      { 
        tag: 'header',
        name: 'Headerfoto',
        page_partable_type: 'Spina::Photo'
      }, {
        tag: 'gallery',
        name: "Gallery",
        page_partable_type: "Spina::PhotoCollection"
      }, {
        tag: 'content',
        name: "Inhoud",
        page_partable_type: "Text"
      }, {
        tag: 'file',
        name: "PDF",
        page_partable_type: 'Spina::Attachment'
      }, {
        tag: 'file',
        name: "Bijlagen",
        page_partable_type: 'Spina::AttachmentCollection'
      }
    ],

    'homepage' => [
      {
        tag: 'left_column',
        name: 'Linkerkolom',
        page_partable_type: 'Text'
      }, {
        tag: 'right_column',
        name: 'Rechterkolom',
        page_partable_type: 'Text'
      }
    ],

    'inquiries' => []
  }


  
  config.default_page_parts = config.PAGE_TYPES['default']
  config.custom_pages = config.PAGE_TYPES.reject { |page_part| page_part == "default" }.keys

  # # Default plugins
  config.NEGATIVE_CAPTCHA_SECRET = 'fee3b3c8b2faa53dafe0978c10c691c29f9c0fdcf12e0052d8c4f5852903707f4a1b6c14f2ac270950b06a287b0683c02a383745025ae6aa3f85091a5deccf06'
  config.plugins = Array.new

  # inquiries = Spina::Plugin.new
  # inquiries.name = "contact"
  # inquiries.class_name = "Spina::Inquiry"
  # inquiries.controller = "inquiries"
  # inquiries.pictos_icon = "z"

  # config.plugins << inquiries


  # Inspiratie ter verbetering van refinery

  # Configure specific page templates
  # config.types.register :home do |home|
  #   home.parts = %w[intro body]
  # end

  # Configure global page default parts
  # config.default_parts = ["Body", "Side Body"]

  # Configure whether to allow adding new page parts
  # config.new_page_parts = false

  # Configure whether to enable marketable_urls
  # config.marketable_urls = true

  # Configure how many pages per page should be displayed when a dialog is presented that contains a links to pages
  # config.pages_per_dialog = 14

  # Configure how many pages per page should be displayed in the list of pages in the admin area
  # config.pages_per_admin_index = 20

  # Configure whether to strip diacritics from Western characters
  # config.approximate_ascii = false

  # Configure whether to strip non-ASCII characters from the friendly_id string
  # config.strip_non_ascii = false

  # Set this to true if you want to override slug which automatically gets generated
  # when you create a page
  # config.use_custom_slugs = false

  # Set this to true if you want backend pages to be cached
  # config.cache_pages_backend = false

  # Set this to true to activate full-page-cache
  # config.cache_pages_full = false

  # Set this to true to fully expand the page hierarchy in the admin
  # config.auto_expand_admin_tree = true

  config.layout_template_whitelist = ["application"]

  config.view_template_whitelist = ["show", "homepage"]

  config.use_layout_templates = true

  config.use_view_templates = true

  # config.page_title = {:chain_page_title=>false, :ancestors=>{:separator=>" | ", :class=>"ancestors", :tag=>"span"}, :page_title=>{:class=>nil, :tag=>nil, :wrap_if_not_chained=>false}}

  # config.absolute_page_links = false


end