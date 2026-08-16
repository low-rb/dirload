# frozen_string_literal: true

require_relative 'adapters/markdown_adapter'
require_relative 'adapters/rbx_adapter'
require_relative 'adapters/ruby_adapter'
require_relative 'loader'
require_relative 'metadata'

module LowLoad
  class UnsupportedFileType < StandardError; end
  class UnsupportedTemplate < StandardError; end

  class << self
    ADAPTERS = [MarkdownAdapter.new, RBXAdapter.new, RubyAdapter.new]

    def dirload(path, pwd = Dir.pwd)
      absolute_path = File.expand_path(path, pwd)
      file_paths = Dir["#{absolute_path}/**/*"].filter { !File.directory?(it) }

      loaded_paths = {}
      missed_paths = []
      file_types = {}

      file_paths.each do |file_path|
        if (adapter = find_adapter(file_path:))
          loaded_paths[file_path] = adapter
        else
          missed_paths << adapter
        end

        file_types[extension(file_path:)] ||= []
        file_types[extension(file_path:)] << file_path
      end

      step(:mapload, loaded_paths:)
      step(:preload, loaded_paths:)
      step(:evaluate, loaded_paths:)

      Metadata.new(loaded_paths:, missed_paths:, file_types:)
    end

    def lowload(file_path)
      adapter = find_adapter(file_path:)

      raise(UnsupportedFileType, "Could not load #{file_path}") if adapter.nil?

      adapter.evaluate(file_path:)
    end

    private

    def step(step, loaded_paths:)
      loaded_paths.each do |file_path, adapter|
        adapter&.send(step, file_path:)
      end
    end

    def find_adapter(file_path:)
      ADAPTERS.find { |adapter| adapter.class::EXTENSIONS.include?(extension(file_path:)) }
    end

    def extension(file_path:)
      File.extname(file_path).delete_prefix('.')
    end
  end
end
