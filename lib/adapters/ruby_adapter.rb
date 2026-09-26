# frozen_string_literal: true

require 'lowkey'
require_relative 'adapter'
require_relative '../loader'

module Dirload
  class RubyAdapter < Adapter
    EXTENSIONS = ['rb'].freeze

    def mapload(file_path:)
      Lowkey.load(file_path)
    end

    def preload(file_path:)
      Loader.add_autoloads(file_proxy: Lowkey[file_path])
    end

    def evaluate(file_path:)
      load(file_path)
    end
  end
end
