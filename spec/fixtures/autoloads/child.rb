# frozen_string_literal: true

module Namespace
  # Includes a module that's only reachable through its superclass.
  class Child < Base
    include Mixin
  end
end
