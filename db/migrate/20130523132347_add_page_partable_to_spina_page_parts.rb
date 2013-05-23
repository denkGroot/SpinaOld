class AddPagePartableToSpinaPageParts < ActiveRecord::Migration
  
  class PagePart < ActiveRecord::Base
  end

  class Gallery < ActiveRecord::Base
    belongs_to :photo
    belongs_to :page_part
  end

  class Photo < ActiveRecord::Base
    has_many :page_parts, through: :galleries
  end

  class File < ActiveRecord::Base
    belongs_to :page_part
  end


  def up
    create_table :spina_photo_collections do |t|
      t.timestamps
    end

    create_table :spina_photo_collections_photos do |t|
      t.integer :photo_collection_id
      t.integer :photo_id
      t.timestamps
    end

    create_table :spina_file_collections do |t|
      t.timestamps
    end

    create_table :spina_file_collections_files do |t|
      t.integer :file_collection_id
      t.integer :file_id
      t.timestamps
    end

    change_table :spina_page_parts do |t|
      t.references :page_partable, polymorphic: true
    end

    PagePart.reset_column_information
    PagePart.all.each do |part|
      case part.type
      when "photo"
        part.update_attributes!{ page_partable_type: "Photo", page_partable_id: part.photo.id }
      when "photos"
        photo_collection = part.create_photo_collection
        part.update_attributes!{ page_partable_type: "PhotoCollection", page_partable_id: photo_collection.id}
        part.galleries.each do |gallery|
          photo_collection.photo_collections_photos.create({ photo_id: gallery.photo_id })
        end
      when "file"
        part.update_attributes!{ page_partable_type: "File", page_partable_id: part.file.id }
      when "files"
        file_collection = part.create_file_collection
        part.update_attributes!{ page_partable_type: "FileCollection", page_partable_id: part.file_collection.id }
        part.files.each do |file|
          file_collection.file_collections_files.create({ file_id: file.id })
        end
      when "text"
        part.update_attributes!{ page_partable_type: "Text", page_partable_id: part.photo.id }
      when "line"
        part.update_attributes!{ page_partable_type: "Line", page_partable_id: part.photo.id }
      end
    end

    drop_table :spina_galleries
    remove_column :spina_page_parts, :content_type

  end

  def down

    change_table :page_parts do |t|
      t.remove_references :page_partable, polymorphic: true
    end

    drop_table :spina_photo_collections
    drop_table :spina_photo_collections_photos
    drop_table :spina_file_collections
    drop_table :spina_file_collections_files

    create_table :spina_galleries do |t|
      t.integer :photo_id
      t.integer :page_part_id

      t.timestamps
    end    
    add_column :spina_page_parts, :content_type
  end

end