# frozen_string_literal: true

require 'antlers' # Dirload will not detect antlers unless another gem (such as LowNode) requires it.
require_relative '../../lib/dirload'

RSpec.describe 'Templates' do
  context 'when Ruby with HEREDOC' do
    it 'loads file without error' do
      dirload('spec/fixtures/templates/html_node.rb')
      expect(HTMLNode.template).to be_nil
    end
  end

  context 'when RBX' do
    it 'wraps RBX in a string' do
      dirload('spec/fixtures/templates/rbx_node.rbx')
      expect(RBXNode.template).to be_nil
    end

    context 'with Antlers' do
      it 'creates template' do
        dirload('spec/fixtures/templates/antlers_node.rbx')
        expect(AntlersNode.template).to have_attributes(template: %(    <p>{"I'm a child"}</p>\n))
      end
    end

    context 'with a configured template engine' do
      let(:engine) do
        Module.new do
          def self.ast(template:, namespace:) = [:custom_ast, template.strip, namespace]
        end
      end

      before { Dirload.configure { |config| config.template_engine = engine } }
      after { Dirload.configure { |config| config.template_engine = nil } }

      it 'creates template with the configured engine' do
        dirload('spec/fixtures/templates/custom_engine_node.rbx')

        expect(CustomEngineNode.template).to have_attributes(engine:, ast: [:custom_ast, %(<p>{"I'm a child"}</p>), 'CustomEngineNode'])
      end
    end

    context 'with HEREDOC' do
      it 'does not wrap RBX in a string' do
        dirload('spec/fixtures/templates/rbx_node.rbx')
        expect(RBXNode.template).to be_nil
      end
    end
  end
end
