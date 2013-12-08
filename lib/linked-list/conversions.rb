module LinkedList
  module Conversions
    module_function

    # +Node()+ tries to convert its argument to +Node+ object by first calling
    # +#to_node+, if that is not availabe then it will instantiate a new +Node+
    # object.
    #
    # == Returns:
    # New +Node+ object.
    #
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
