Spina.page_part_types = [:text, :photo, :line]
Spina.default_page_parts = [{
    name: "Linkerkolom",
    tag: "left_column",
    content_type: "text"
  },
  {
    name: "Rechterkolom",
    tag: "right_column",
    content_type: "text"
  }
]
Spina.special_pages = [:homepage, :contact]

Spina.plugins = Array.new