# frozen_string_literal: true

require_relative 'adapter'

module Dirload
  class MarkdownAdapter < Adapter
    EXTENSIONS = %w[md rd markdown raindown].freeze
  end
end
