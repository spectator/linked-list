module LinkedList
  class Node
    attr_accessor :data, :next, :prev

    def initialize(data)
      @data = data
      @next = nil
      @prev = nil
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
