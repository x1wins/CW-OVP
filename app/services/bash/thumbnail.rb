module Bash
  class Thumbnail < ApplicationService
    def initialize(uploaded_file_path, ss, thumbnail_file_full_path)
      @uploaded_file_path = uploaded_file_path
      @ss = ss
      @thumbnail_file_full_path= thumbnail_file_full_path
    end

    def call
      `sh app/encoding/thumbnail.sh #{@uploaded_file_path} #{@ss} #{@thumbnail_file_full_path}`
    end
  end
end