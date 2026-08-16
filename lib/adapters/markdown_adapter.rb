# frozen_string_literal: true

require 'yaml'
require 'lowkey'
require_relative 'adapter'

module LowLoad
  class MarkdownAdapter < Adapter
    EXTENSIONS = %w[md rd markdown raindown].freeze
  end
end
