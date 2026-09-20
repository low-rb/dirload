# frozen_string_literal: true

require_relative 'adapters/markdown_adapter'

module Dirload
  class Metadata
    EXTENSIONS = [
      *::Dirload::MarkdownAdapter::EXTENSIONS,
      *::Dirload::RBXAdapter::EXTENSIONS,
      *::Dirload::RubyAdapter::EXTENSIONS
    ].freeze

    attr_accessor :loaded_paths, :missed_paths, :file_types

    def initialize(loaded_paths:, missed_paths:, file_types:)
      @loaded_paths = loaded_paths
      @missed_paths = missed_paths
      @file_types = file_types
    end
  end
end
