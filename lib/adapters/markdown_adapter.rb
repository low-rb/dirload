# frozen_string_literal: true

require 'yaml'
require 'lowkey'
require_relative 'adapter'

module LowLoad
  class MarkdownAdapter < Adapter
    EXTENSIONS = ['md', 'rd', 'markdown', 'raindown']

    def metadata(file_path:)
      line_numbers = []
      yaml_lines = []

      File.foreach(file_path).with_index do |line, index|
        if line.strip == '---'
          line_numbers << index + 1
          break if line_numbers.count > 1
        elsif line_numbers.count > 0
          yaml_lines << line
        end
      end

      # TODO: Test that this returns an empty hash when no yaml lines found.
      YAML.safe_load(yaml_lines.join, symbolize_names: true)
    end

    def url_path(file_path:)
      # Remove "_number-" and segments beginning with "_".
      url_path = file_path.split('/').map do |segment|
        next segment.sub(/^_\d\W/, '') if segment.sub(/^_\d\W/, '') != segment
        next nil if segment.sub(/^_/, '') != segment

        segment
      end.compact.join('/')
      
      EXTENSIONS.each do |extension|
        url_path.delete_suffix!(".#{extension}")
      end

      url_path
    end
  end
end
