# frozen_string_literal: true

# rubocop:disable Lint/UnusedMethodArgument

module Dirload
  # A step is run on all files before moving on to the next step.
  class Adapter
    EXTENSIONS = [].freeze

    # Map definitions and dependencies.
    def mapload(file_path:) = nil

    # Then autoload all dependencies for those files.
    def preload(file_path:) = nil

    # Now we can load the file into Ruby.
    def evaluate(file_path:, top_level_binding: nil) = nil
  end
end

# rubocop:enable Lint/UnusedMethodArgument
