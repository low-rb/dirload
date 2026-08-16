# frozen_string_literal: true

require_relative '../../lib/lowload'

RSpec.describe LowLoad do
  describe '.dirload' do
    it 'autoloads directories' do
      LowLoad.dirload('spec/fixtures')

      expect(Namespace::A).not_to be(nil)
      expect(Namespace::B).not_to be(nil)
      expect(Namespace::C).not_to be(nil)
    end
  end
end
