# frozen_string_literal: true

require 'lownode'

# A LowNode with template syntax, built by a configured template engine.
class CustomEngineNode < LowNode
  def render(event:)
    <p>{"I'm a child"}</p>
  end
end
