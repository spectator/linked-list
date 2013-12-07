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
end
