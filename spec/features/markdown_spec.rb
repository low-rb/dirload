# frozen_string_literal: true

require_relative '../../lib/dirload'

RSpec.describe 'Markdown' do
  context 'with markdown files' do
    let(:metadata) { dirload('spec/fixtures/markdown') }

    it 'loads files' do
      expect(metadata.loaded_paths).to match(
        {
          "#{Dir.pwd}/spec/fixtures/markdown/markdown.md" => be_an_instance_of(Dirload::MarkdownAdapter),
          "#{Dir.pwd}/spec/fixtures/markdown/raindown.md" => be_an_instance_of(Dirload::MarkdownAdapter)
        }
      )
    end
  end
end
