module Bash
  class Runtime < ApplicationService
    def initialize(uploaded_file_path)
      @uploaded_file_path = uploaded_file_path
    end

    def call
      `sh app/encoding/runtime.sh #{@uploaded_file_path}`
    end
  end
end