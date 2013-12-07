module LinkedList
  module Conversions
    module_function

    def Node(*args)
      case args.first
      when ->(arg) { arg.respond_to?(:to_node) }
        args.first.to_node
      else
        Node.new(args.first)
      end
    end
  end
end
