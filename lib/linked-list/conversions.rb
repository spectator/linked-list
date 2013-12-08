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

    # +List()+ tries to conver its argument to +List+ object by first calling
    # +#to_list+, if that is not availabe and its argument is an array (or can
    # be convertd into array with +#to_ary+) then it will instantiate a new
    # +List+ object making nodes from array elements. If none above applies,
    # then a new +List+ will be instantiated with one node holding argument
    # value.
    #
    # == Returns:
    # New +List+ object.
    #
    def List(*args)
      case args.first
      when ->(arg) { arg.respond_to?(:to_list) }
        args.first.to_list
      when ->(arg) { arg.respond_to?(:to_ary) }
        args.first.to_ary.each_with_object(List.new) { |n, l| l.push(Node(n)) }
      else
        List.new.push(Node(args.first))
      end
    end
  end
end
