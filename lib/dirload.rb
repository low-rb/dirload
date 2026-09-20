# frozen_string_literal: true

require_relative 'adapters/markdown_adapter'
require_relative 'adapters/rbx_adapter'
require_relative 'adapters/ruby_adapter'
require_relative 'loader'
require_relative 'metadata'

module Dirload
  class UnsupportedFileType < StandardError; end
  class UnsupportedTemplate < StandardError; end

  ADAPTERS = [MarkdownAdapter.new, RBXAdapter.new, RubyAdapter.new].freeze

  def dirload(path, pwd = Dir.pwd, error: false) # rubocop:disable Metrics/AbcSize
    absolute_path = File.expand_path(path, pwd)

    return adapter_load(file_path: absolute_path) unless File.directory?(absolute_path)

    loaded_paths = {}
    missed_paths = []
    file_types = {}

    file_paths(absolute_path:).each do |file_path|
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

  private

  def file_paths(absolute_path:)
    Dir["#{absolute_path}/**/*"].filter { !File.directory?(it) }
  end

  def adapter_load(file_path:)
    adapter = find_adapter(file_path:)

    raise(UnsupportedFileType, "Could not load #{file_path}") if adapter.nil?

    adapter.evaluate(file_path:)
  end

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

Kernel.send(:include, Dirload)
