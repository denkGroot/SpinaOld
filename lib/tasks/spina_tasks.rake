# # desc "Explaining what the task does"
# # task :spina do
# #   # Task goes here
# # end

# namespace :spina do
#   desc "Generate custom pages"
#   task generate_pages: [:create_custom_pages, :destroy_unused_pages]

#   desc "Create custom pages from spina config"
#   task :create_custom_pages => :environment do
#     puts "Creating custom pages from spina config..."
#     Spina::Engine.config.custom_pages.each do |page|
#       Spina::Page.where(name: page.downcase).where(deletable: false).first_or_create! if page
#     end
#     puts "Done"
#   end

#   desc "Destroy custom pages not in spina config"
#   task :destroy_unused_pages => :environment do
#     puts "Destroying custom pages not in spina config..."

#     Spina::Page.all.each do |page|
#       if page.deletable?
#         page_type_config = Spina::Engine.config.PAGE_TYPES["default"]
#       elsif Spina::Engine.config.custom_pages.include? page.name.downcase
#         page_type_config = Spina::Engine.config.PAGE_TYPES[page.name.downcase]
#       else
#         page.destroy
#         next
#       end

#       page.page_parts.each do |page_part|
#         page_part_config = page_type_config.find { |page_part_config| page_part_config[:tag] ==  page_part.tag }
#         if page_part_config.blank? || page_part.page_partable_type != page_part_config[:page_partable_type]
#           page_part.destroy
#         elsif page_part.name != page_part_config[:name]
#           page_part.update_attribute(:name, page_part_config[:name])
#         end
#       end
    
#     end

#     puts "Done"
#   end
# end
