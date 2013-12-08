require 'test_helper'

describe LinkedList::List do
  let(:list)   { create_list }
  let(:node_1) { create_node('foo') }
  let(:node_2) { create_node('bar') }

  describe 'instantiation' do
    it 'assigns head to nil' do
      assert_nil list.head
    end

    it 'assigns tail to nil' do
      assert_nil list.tail
    end

    it 'has zero length' do
      assert_equal 0, list.length
    end
  end

  describe '#push' do
    it 'last pushed node can be accessed with #tail' do
      list.push(node_1)
      assert_equal node_1, list.tail
    end

    it 'last pushed node can be accessed with #head' do
      list.push(node_1)
      assert_equal node_1, list.head
    end

    it 'maintains first pushed node as head' do
      list.push(node_1)
      list.push(node_2)
      assert_equal node_1, list.head
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
    it 'last pushed node can be accessed with #tail' do
      list.unshift(node_1)
      assert_equal node_1, list.tail
    end

    it 'last pushed node can be accessed with #head' do
      list.unshift(node_1)
      assert_equal node_1, list.head
    end

    it 'maintains first pushed node as tail' do
      list.unshift(node_1)
      list.unshift(node_2)
      assert_equal node_1, list.tail
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

    it 'sets #tail to nil when all nodes are removed' do
      list.push(node_1)
      list.pop
      assert_nil list.tail
    end

    it 'sets #head to nil when all nodes are removed' do
      list.push(node_1)
      list.pop
      assert_nil list.head
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

    it 'sets #tail to nil when all nodes are removed' do
      list.push(node_1)
      list.shift
      assert_nil list.tail
    end

    it 'sets #head to nil when all nodes are removed' do
      list.push(node_1)
      list.shift
      assert_nil list.head
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
      assert_equal [node_2, node_1], [list.head, list.tail]
    end

    it 'returns same object' do
      list.push(node_1)
      assert_equal list, list.reverse!
    end
  end

  describe 'conversion' do
    it '#to_list returns self' do
      assert_equal list, list.to_list
    end
  end
end
