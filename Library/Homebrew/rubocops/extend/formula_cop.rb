module RuboCop
  module Cop
    class FormulaCop < Cop
      @registry = Cop.registry

      def file_inside_formula_root?
        return false unless processed_source.path =~ %r{/Taps/homebrew}
        true
      end

      def on_class(node)
        return unless file_inside_formula_root?
        class_node, parent_class_node, body = *node
        return unless parent_class_node && parent_class_node.const_name == "Formula"
        on_formula(node, class_node, parent_class_node, body)
      end
    end
  end
end
