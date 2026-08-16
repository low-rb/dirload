# frozen_string_literal: true

require_relative 'adapters/markdown_adapter'

module LowLoad
  class Metadata
    EXTENSIONS = [
      *::LowLoad::MarkdownAdapter::EXTENSIONS,
      *::LowLoad::RBXAdapter::EXTENSIONS,
      *::LowLoad::RubyAdapter::EXTENSIONS,
    ]

    attr_accessor :loaded_paths, :missed_paths, :file_types

    def initialize(loaded_paths:, missed_paths:, file_types:)
      @loaded_paths = loaded_paths
      @missed_paths = missed_paths
      @file_types = file_types
    end
  end
end
