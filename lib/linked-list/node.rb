module LinkedList
  class Node
    attr_accessor :data, :next

    def initialize(data)
      @data = data
      @next = nil
    end

    # Conversion function, see +Conversions.Node+.
    #
    def to_node
      self
    end
  end
end
