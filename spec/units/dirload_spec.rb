# frozen_string_literal: true

require_relative '../../lib/dirload'

module Namespace
  class Base
    module Mixin; end
  end
end

RSpec.describe Dirload do
  describe '.dirload' do
    it 'autoloads directories' do
      dirload('spec/fixtures')

      expect(Namespace::A).not_to be(nil)
      expect(Namespace::B).not_to be(nil)
      expect(Namespace::C).not_to be(nil)
    end

    it 'loads a module included from a superclass' do
      dirload('spec/fixtures')

      expect(Namespace::Child.include?(Namespace::Base::Mixin)).to be(true)
    end
  end
end
