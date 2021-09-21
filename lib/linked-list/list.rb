# frozen_string_literal: true

module LinkedList
  class List
    include Conversions

    attr_reader :length
    alias_method :size, :length

    def initialize
      @head   = nil
      @tail   = nil
      @length = 0
    end

    # Returns the first element of the list or nil.
    #
    def first
      @head && @head.data
    end

    # Returns the last element of the list or nil.
    #
    def last
      @tail && @tail.data
    end

    # Pushes new nodes to the end of the list.
    #
    # == Parameters:
    # node:: Any object, including +Node+ objects.
    #
    # == Returns:
    # +self+ of +List+ object.
    #
    def push(node)
      node = Node(node)
      @head ||= node

      if @tail
        @tail.next = node
        node.prev = @tail
      end

      @tail = node

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
    # +self+ of +List+ object.
    #
    def unshift(node)
      node = Node(node)
      @tail ||= node

      node.next = @head
      @head.prev = node if @head
      @head = node

      @length += 1
      self
    end

    # Inserts after or before first matched node.data from the the list by passed block or value.
    #
    # == Returns:
    # Inserted node data
    #
    def insert(to_add, after: nil, before: nil)
      if after && before || !after && !before
        raise ArgumentError, 'either :after or :before keys should be passed'
      end
      matcher = after || before
      matcher_proc = if matcher.is_a?(Proc)
                       __to_matcher(&matcher)
                     else
                       __to_matcher(matcher)
                     end
      node = each_node.find(&matcher_proc)
      return unless node
      new_node = after ? insert_after_node(to_add, node) : insert_before_node(to_add, node)
      new_node.data
    end

    # Inserts data after first matched node.data.
    #
    # == Returns:
    # Inserted node
    #
    def insert_after_node(data, node)
      Node(data).tap do |new_node|
        new_node.prev = node
        new_node.next = node.next
        if node.next
          node.next.prev = new_node
        else
          @tail = new_node
        end
        node.next = new_node
        @length += 1
      end
    end

    # Inserts data before first matched node.data.
    #
    # == Returns:
    # Inserted node
    #
    def insert_before_node(data, node)
      Node(data).tap do |new_node|
        new_node.next = node
        new_node.prev = node.prev
        if node.prev
          node.prev.next = new_node
        else
          @head = new_node
        end
        node.prev = new_node
        @length += 1
      end
    end

    # Removes first matched node.data from the the list by passed block or value.
    #
    # If +val+ is a +Node+, removes that node from the list. Behavior is
    # undefined if +val+ is a +Node+ that's not a member of this list.
    #
    # == Returns:
    # Deleted node's data
    #
    def delete(val = nil, &block)
      if val.respond_to?(:to_node)
        node = val.to_node
        __unlink_node(node)
        return node.data
      end

      each_node.find(&__to_matcher(val, &block)).tap do |node_to_delete|
        return unless node_to_delete
        __unlink_node(node_to_delete)
      end.data
    end

    # Removes all matched data.data from the the list by passed block or value.
    #
    # == Returns:
    # Array of deleted nodes
    #
    def delete_all(val = nil, &block)
      each_node.select(&__to_matcher(val, &block)).each do |node_to_delete|
        next unless node_to_delete
        __unlink_node(node_to_delete)
      end.map(&:data)
    end

    # Removes data from the end of the list.
    #
    # == Returns:
    # Data stored in the node or nil.
    #
    def pop
      return nil unless @head

      tail = __pop
      @head = nil unless @tail

      @length -= 1
      tail.data
    end

    # Removes data from the beginning of the list.
    #
    # == Returns:
    # Data stored in the node or nil.
    #
    def shift
      return nil unless @head

      head = __shift
      @tail = nil unless @head

      @length -= 1
      head.data
    end

    # Reverse list of nodes and returns new instance of the list.
    #
    # == Returns:
    # New +List+ in reverse order.
    #
    def reverse
      List(to_a).reverse!
    end

    # Reverses list of nodes in place.
    #
    # == Returns:
    # +self+ in reverse order.
    #
    def reverse!
      return self unless @head

      __each do |curr_node|
        curr_node.prev, curr_node.next = curr_node.next, curr_node.prev
      end
      @head, @tail = @tail, @head

      self
    end

    # Iterates over nodes from top to bottom passing node data to the block if
    # given. If no block given, returns +Enumerator+.
    #
    # == Returns:
    # +Enumerator+ or yields data to the block stored in every node on the
    # list.
    #
    def each
      return to_enum(__callee__) unless block_given?
      __each { |node| yield(node.data) }
    end

    # Iterates over nodes from top to bottom passing node(LinkedList::Node instance)
    # to the block if given. If no block given, returns +Enumerator+.
    #
    # == Returns:
    # +Enumerator+ or yields list nodes to the block
    #
    def each_node
      return to_enum(__callee__) unless block_given?
      __each { |node| yield(node) }
    end


    # Iterates over nodes from bottom to top passing node data to the block if
    # given. If no block given, returns +Enumerator+.
    #
    # == Returns:
    # +Enumerator+ or yields data to the block stored in every node on the
    # list.
    #
    def reverse_each
      return to_enum(__callee__) unless block_given?
      __reverse_each { |node| yield(node.data) }
    end

    # Iterates over nodes from bottom to top passing node(LinkedList::Node instance)
    # to the block if given. If no block given, returns +Enumerator+.
    #
    # == Returns:
    # +Enumerator+ or yields list nodes to the block
    #
    def reverse_each_node
      return to_enum(__callee__) unless block_given?
      __reverse_each { |node| yield(node) }
    end

    # Converts list to array.
    #
    def to_a
      each.to_a
    end
    alias_method :to_ary, :to_a

    def inspect
      sprintf('#<%s:%#x %s>', self.class, self.__id__, to_a.inspect)
    end

    # Conversion function, see +Conversions.List+.
    #
    # == Returns:
    # +self+
    #
    def to_list
      self
    end

    private

    def __unlink_node(node)
      @head = node.next if node.prev.nil?
      @tail = node.prev if node.next.nil?

      if node.prev.nil?
        node.next.prev = nil if node.next
      elsif node.next.nil?
        node.prev.next = nil if node.prev
      else
        node.prev.next, node.next.prev = node.next, node.prev
      end
      @length -= 1
    end

    def __to_matcher(val = nil, &block)
      raise ArgumentError, 'either value or block should be passed' if val && block_given?
      block = ->(e) { e == val } unless block_given?
      ->(node) { block.call(node.data) }
    end

    def __shift
      head = @head
      @head = @head.next
      @head.prev = nil if @head
      head
    end

    def __pop
      tail = @tail
      @tail = @tail.prev
      @tail.next = nil if @tail
      tail
    end

    def __reverse_each
      curr_node = @tail
      while(curr_node)
        yield curr_node
        curr_node = curr_node.prev
      end
    end

    def __each
      curr_node = @head
      while(curr_node)
        yield curr_node
        curr_node = curr_node.next
      end
    end
  end
end
