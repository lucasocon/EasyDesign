module Picturable
  extend ActiveSupport::Concern
  included do
    after_save :save_image    
  end
  if self.respond_to?(:nombre)
    PATH_FILES = File.join Rails.root, "public", "files", "attachments"
  else
    PATH_FILES = File.join Rails.root, "public", "files", "posts"
  end

  def file=(file)
    unless file.blank?  
        @file = file
        if self.respond_to?(:nombre)
         self.nombre = file.original_filename
        end
        if self.respond_to?(:extension)
        self.extension = file.original_filename.split(".").last.downcase
        end
      end
    end

    def path_file
      File.join PATH_FILES, "#{self.id}.#{self.extension}"
    end

    def has_file?
      File.exists? path_file
    end 

  private
    def save_image
      if @file
        FileUtils.mkdir_p PATH_FILES
        File.open(path_file, "wb") do |f|
          f.write(@file.read)
        end
        @file = nil
      end
    end
end
