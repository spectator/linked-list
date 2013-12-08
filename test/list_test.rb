require 'test_helper'

describe LinkedList::List do
  let(:list)   { create_list }
  let(:node_1) { create_node('foo') }
  let(:node_2) { create_node('bar') }

  describe 'instantiation' do
    it 'assigns first to nil' do
      assert_nil list.first
    end

    it 'assigns last to nil' do
      assert_nil list.last
    end

    it 'has zero length' do
      assert_equal 0, list.length
    end
  end

  describe '#push' do
    it 'last pushed node can be accessed with #last' do
      list.push(node_1)
      assert_equal node_1.data, list.last
    end

    it 'last pushed node data can be accessed with #first' do
      list.push(node_1)
      assert_equal node_1.data, list.first
    end

    it 'maintains first pushed node as first' do
      list.push(node_1)
      list.push(node_2)
      assert_equal node_1.data, list.first
    end

    it 'sets reference to the next node' do
      list.push(node_1)
      list.push(node_2)
      assert_equal node_1.next, node_2
    end

    it 'increases list length by 1' do
      list.push(node_1)
      assert_equal 1, list.length
    end

    it 'returns self' do
      assert_equal list.push(node_1), list
    end
  end

  describe '#unshift' do
    it 'last pushed node can be accessed with #last' do
      list.unshift(node_1)
      assert_equal node_1.data, list.last
    end

    it 'last pushed node can be accessed with #first' do
      list.unshift(node_1)
      assert_equal node_1.data, list.first
    end

    it 'maintains first pushed node as last' do
      list.unshift(node_1)
      list.unshift(node_2)
      assert_equal node_1.data, list.last
    end

    it 'sets reference to the next node' do
      list.unshift(node_1)
      list.unshift(node_2)
      assert_equal node_2.next, node_1
    end

    it 'increases list length by 1' do
      list.unshift(node_1)
      assert_equal 1, list.length
    end

    it 'returns self' do
      assert_equal list.unshift(node_1), list
    end
  end

  describe '#pop' do
    it 'returns nil if list is empty' do
      assert_nil list.pop
    end

    it 'returns node from the end of the list' do
      list.push(node_1)
      list.push(node_2)
      assert_equal node_2.data, list.pop
    end

    it 'sets #last to nil when all nodes are removed' do
      list.push(node_1)
      list.pop
      assert_nil list.last
    end

    it 'sets #first to nil when all nodes are removed' do
      list.push(node_1)
      list.pop
      assert_nil list.first
    end

    it 'reduces list length by 1' do
      list.push(node_1)
      list.pop
      assert_equal 0, list.length
    end
  end

  describe '#shift' do
    it 'returns nil if list is empty' do
      assert_nil list.shift
    end

    it 'returns node from the top of the list' do
      list.push(node_1)
      list.push(node_2)
      assert_equal node_1.data, list.shift
    end

    it 'sets #last to nil when all nodes are removed' do
      list.push(node_1)
      list.shift
      assert_nil list.last
    end

    it 'sets #first to nil when all nodes are removed' do
      list.push(node_1)
      list.shift
      assert_nil list.first
    end

    it 'reduces list length by 1' do
      list.push(node_1)
      list.shift
      assert_equal 0, list.length
    end
  end

  describe '#reverse!' do
    it 'returns self when list is empty' do
      assert_equal list, list.reverse!
    end

    it 'reverses order of nodes' do
      list.push(node_1)
      list.push(node_2)
      list.reverse!
      assert_equal [node_2.data, node_1.data], [list.first, list.last]
    end

    it 'returns same object' do
      list.push(node_1)
      assert_equal list, list.reverse!
    end
  end

  describe '#each' do
    it 'returns enumerator if no block given' do
      assert_instance_of Enumerator, list.each
    end

    it 'pass each node data to the block' do
      list.push(node_1)
      list.push(node_2)
      nodes = []
      list.each { |e| nodes << e }
      assert_equal ['foo', 'bar'], nodes
    end
  end

  describe 'conversion' do
    it '#to_list returns self' do
      assert_equal list, list.to_list
    end
  end
end
