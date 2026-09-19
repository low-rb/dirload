# frozen_string_literal: true

require 'lownode'

class HTMLNode < LowNode
  def render
    <<~HTML
      <p>Hello</p>
    HTML
  end
end
