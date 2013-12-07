module LinkedList
  class List
    include Conversions

    attr_reader  :first, :last, :length
    alias_method :size, :length

    def initialize
      @first  = nil
      @last   = nil
      @length = 0
    end

    # Pushes new nodes to the end of the list.
    #
    # == Parameters:
    # node:: Any object, including +Node+ objects.
    #
    # == Returns:
    # self of +List+ object.
    #
    def push(node)
      node = Node(node)
      @first ||= node

      @last.next = node if @last
      @last = node

      @length += 1
      self
    end
    alias_method :<<, :push

    # Pushes new nodes on top of the list.
    #
    # == Parameters:
    # node:: Any object, including +Node+ objects.
    #
    # == Returns:
    # self of +List+ object.
    #
    def unshift(node)
      node = Node(node)
      @last ||= node

      node.next = @first
      @first = node

      @length += 1
      self
    end

    # Removes node from the end of the list.
    #
    # == Returns:
    # Data stored in the node or nil.
    #
    def pop
      return nil unless @first

      node = @first
      next_to_last = nil
      while(node = node.next)
        next_to_last = node unless node.next
      end
      @first = nil unless next_to_last

      last = @last
      @last = next_to_last

      @length -= 1
      last.data
    end

    # Removes node from the beginning of the list.
    #
    # == Returns:
    # Data stored in the node or nil.
    #
    def shift
      return nil unless @first

      first = @first
      @first = @first.next
      @last = nil unless @first

      @length -= 1
      first.data
    end

    # Reverses list of nodes in place.
    #
    # == Returns:
    # self in reverse order.
    #
    def reverse!
      return self unless @first

      prev_node = @first
      @first = @first.next
      prev_node.next = nil
      @last = prev_node

      while(@first)
        curr_node = @first
        @first = @first.next
        curr_node.next = prev_node
        prev_node = curr_node
      end
      @first = prev_node
    end
  end
end
