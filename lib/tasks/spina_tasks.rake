# desc "Explaining what the task does"
# task :spina do
#   # Task goes here
# end

namespace :spina do
  desc "Generate custom pages"
  task generate_pages: [:create_custom_pages, :destroy_unused_pages]

  desc "Create custom pages from spina.yml"
  task :create_custom_pages => :environment do
    puts "Creating custom pages from spina.yml..."
    Spina.custom_pages.each do |page|
      Spina::Page.find_or_create_by_title_and_deletable(title: page.capitalize, deletable: false) if page
    end
    puts "Done"
  end

  desc "Destroy custom pages not in spina.yml"
  task :destroy_unused_pages => :environment do
    puts "Destroying custom pages not in spina.yml..."
    Spina::Page.custom_pages.each do |page|
      page.destroy unless Spina.custom_pages.include? page.title.downcase
    end
    puts "Done"
  end
end
