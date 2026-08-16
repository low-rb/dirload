# frozen_string_literal: true

require_relative '../../lib/lowload'

RSpec.describe 'Markdown' do
  context 'with markdown files' do
    let(:metadata) { LowLoad.dirload('spec/fixtures/markdown') }

    it 'loads files' do
      expect(metadata.loaded_paths).to match({
        "#{Dir.pwd}/spec/fixtures/markdown/markdown.md" => be_an_instance_of(LowLoad::MarkdownAdapter),
        "#{Dir.pwd}/spec/fixtures/markdown/raindown.md" => be_an_instance_of(LowLoad::MarkdownAdapter),
      })
    end
  end
end
