require 'test_helper'

describe LinkedList::Conversions do
  describe 'Node()' do
    it 'returns self if node is given' do
      node = create_node('foo')
      assert_equal LinkedList::Conversions.Node(node), node
    end

    it 'returns new node' do
      assert_instance_of LinkedList::Node,
        LinkedList::Conversions.Node('foo')
    end
  end

  describe 'List()' do
    it 'returns self if list is given' do
      list = create_list
      assert_equal LinkedList::Conversions.List(list), list
    end

    it 'returns list with nodes made from array' do
      list = LinkedList::Conversions.List([1, 2])
      assert_equal [1, 2], [list.first, list.last]
    end

    it 'returns new list with one node' do
      list = LinkedList::Conversions.List('foo')
      assert_equal 'foo', list.first
    end
  end
end
