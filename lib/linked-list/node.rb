# frozen_string_literal: true

module LinkedList
  class Node
    attr_accessor :data, :next, :prev
    attr_reader :list

    def initialize(data, list = nil)
      @data = data
      @next = nil
      @prev = nil
      @list = list
    end

    def insert_after(data)
      Node.new(data, list).tap do |new_node|
        new_node.prev = self
        new_node.next = self.next
        if self.next
          self.next.prev = new_node
        else
          list.tail = new_node
        end
        self.next = new_node
        list.length += 1
      end.data
    end

    def insert_before(data)
      Node.new(data, list).tap do |new_node|
        new_node.next = self
        new_node.prev = prev
        if prev
          prev.next = new_node
        else
          list.head = new_node
        end
        self.prev = new_node
        list.length += 1
      end.data
    end

    def unlink
      if prev.blank?
        self.next.prev = nil if self.next
        list.head = self.next
      elsif self.next.blank?
        prev.next = nil if prev
        list.tail = prev
      else
        prev.next, self.next.prev = self.next, prev
      end
      list.length -= 1
    end

    # Conversion function, see +Conversions.Node+.
    #
    # == Returns:
    # self
    #
    def to_node
      self
    end
  end
end
