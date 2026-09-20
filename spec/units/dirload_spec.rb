# frozen_string_literal: true

require_relative '../../lib/dirload'

RSpec.describe Dirload do
  describe '.dirload' do
    it 'autoloads directories' do
      dirload('spec/fixtures')

      expect(Namespace::A).not_to be(nil)
      expect(Namespace::B).not_to be(nil)
      expect(Namespace::C).not_to be(nil)
    end
  end
end
