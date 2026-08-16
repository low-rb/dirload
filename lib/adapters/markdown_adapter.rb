# frozen_string_literal: true

require 'yaml'
require 'lowkey'
require_relative 'adapter'

module LowLoad
  class MarkdownAdapter < Adapter
    EXTENSIONS = ['md', 'rd', 'markdown', 'raindown']
  end
end
