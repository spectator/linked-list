require 'test_helper'

describe LinkedList::List do
  let(:list)   { create_list }
  let(:node_1) { create_node('foo') }
  let(:node_2) { create_node('bar') }
  let(:node_3) { create_node('baz') }

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

    it 'sets reference to the prev node' do
      list.push(node_1)
      list.push(node_2)
      assert_equal node_2.prev, node_1
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

    it 'sets reference to the prev node' do
      list.unshift(node_1)
      list.unshift(node_2)
      assert_equal node_1.prev, node_2
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

    it 'maintains list when multiple nodes are removed' do
      list.push(node_1)
      list.push(node_2)
      list.pop
      assert_equal [node_1.data], list.to_a
    end
  end

  describe '#insert' do
    it 'raises error if after and before are passed' do
      err = assert_raises ArgumentError do
        assert_nil list.insert(1, after: 'x', before: 'y')
      end
      assert_equal err.message, 'either :after or :before keys should be passed'
    end

    it 'raises error if no after nore before are passed' do
      err = assert_raises ArgumentError do
        assert_nil list.insert(1)
      end
      assert_equal err.message, 'either :after or :before keys should be passed'
    end

    describe 'after:' do
      describe 'by block' do
        it 'does not add value if insert after not found' do
          list.push('foo')
          assert_nil list.insert(1, after: ->(d) { d == 'foo1' })
          assert_equal ['foo'], list.to_a
        end

        it 'inserts value after first matching node by block' do
          list.push('foo')
          list.push('bar')
          assert_equal 1, list.insert(1, after: ->(d) { d == 'foo' })
          assert_equal ['foo', 1, 'bar'], list.to_a
          assert_equal 3, list.length
        end

        describe 'position edge cases' do
          before do
            list.push(0)
            list.push(1)
            list.push(2)
          end

          it 'inserts after in the middle' do
            list.insert('foo', after: ->(d) { d == 0 })
            assert_equal [0, 'foo', 1, 2], list.to_a
          end

          it 'inserts after the tail' do
            list.insert('foo', after: ->(d) { d == 2 })
            assert_equal [0, 1, 2, 'foo'], list.to_a
            assert_equal 'foo', list.last
          end
        end
      end

      describe 'by value' do
        it 'does not add value if insert after not found' do
          list.push('foo')
          assert_nil list.insert(1, after: 'foo1')
          assert_equal ['foo'], list.to_a
        end

        it 'inserts value after first matching node by block' do
          list.push('foo')
          list.push('bar')
          assert_equal 1, list.insert(1, after: 'foo')
          assert_equal ['foo', 1, 'bar'], list.to_a
          assert_equal 3, list.length
        end

        describe 'position edge cases' do
          before do
            list.push(0)
            list.push(1)
            list.push(2)
          end

          it 'inserts after in the middle' do
            list.insert('foo', after: 0)
            assert_equal [0, 'foo', 1, 2], list.to_a
          end

          it 'inserts after the tail' do
            list.insert('foo', after: 2)
            assert_equal [0, 1, 2, 'foo'], list.to_a
            assert_equal 'foo', list.last
          end
        end
      end
    end

    describe ':before' do
      describe 'by block' do
        it 'does not add value if insert before not found' do
          list.push('foo')
          assert_nil list.insert(1, before: ->(d) { d == 'foo1' })
          assert_equal ['foo'], list.to_a
        end

        it 'inserts value before first matching node by block' do
          list.push('foo')
          list.push('bar')
          assert_equal 1, list.insert(1, before: ->(d) { d == 'foo' })
          assert_equal [1, 'foo', 'bar'], list.to_a
          assert_equal 3, list.length
        end

        describe 'position edge cases' do
          before do
            list.push(0)
            list.push(1)
            list.push(2)
          end

          it 'inserts before head' do
            list.insert('foo', before: ->(d) { d == 0 })
            assert_equal ['foo', 0, 1, 2], list.to_a
            assert_equal 'foo', list.first
          end

          it 'inserts before in the middle' do
            list.insert('foo', before: ->(d) { d == 2 })
            assert_equal [0, 1, 'foo', 2], list.to_a
          end
        end
      end

      describe 'by value' do
        it 'does not add value if insert before not found' do
          list.push('foo')
          assert_nil list.insert(1, before: 'foo1')
          assert_equal ['foo'], list.to_a
        end

        it 'inserts value before first' do
          list.push('foo')
          list.push('bar')
          assert_equal 1, list.insert(1, before: 'foo')
          assert_equal [1, 'foo', 'bar'], list.to_a
          assert_equal 3, list.length
        end

        describe 'position edge cases' do
          before do
            list.push(0)
            list.push(1)
            list.push(2)
          end

          it 'inserts before head' do
            list.insert('foo', before: 0)
            assert_equal ['foo', 0, 1, 2], list.to_a
            assert_equal 'foo', list.first
          end

          it 'inserts before in the middle' do
            list.insert('foo', before: 2)
            assert_equal [0, 1, 'foo', 2], list.to_a
          end
        end
      end
    end
  end

  describe '#insert_after_node' do
    it 'inserts value after passed node' do
      list.push('foo')
      list.push('bar')
      node = list.each_node.find { |n| n.data == 'foo' }
      assert_equal 1, list.insert_after_node(1, node).data
      assert_equal ['foo', 1, 'bar'], list.to_a
      assert_equal 3, list.length
    end

    describe 'position edge cases' do
      before do
        list.push(0)
        list.push(1)
        list.push(2)
      end

      it 'inserts after in the middle' do
        node = list.each_node.find { |n| n.data == 0 }
        list.insert_after_node('foo', node)
        assert_equal [0, 'foo', 1, 2], list.to_a
      end

      it 'inserts after the tail' do
        node = list.each_node.find { |n| n.data == 2 }
        list.insert_after_node('foo', node)
        assert_equal [0, 1, 2, 'foo'], list.to_a
        assert_equal 'foo', list.last
      end
    end
  end

  describe '#insert_after_node' do
    it 'inserts value before first' do
      list.push('foo')
      list.push('bar')
      node = list.each_node.find { |n| n.data == 'foo' }
      assert_equal 1, list.insert_before_node(1, node).data
      assert_equal [1, 'foo', 'bar'], list.to_a
      assert_equal 3, list.length
    end

    describe 'position edge cases' do
      before do
        list.push(0)
        list.push(1)
        list.push(2)
      end

      it 'inserts before head' do
        node = list.each_node.find { |n| n.data == 0 }
        list.insert_before_node('foo', node)
        assert_equal ['foo', 0, 1, 2], list.to_a
        assert_equal 'foo', list.first
      end

      it 'inserts before in the middle' do
        node = list.each_node.find { |n| n.data == 2 }
        list.insert_before_node('foo', node)
        assert_equal [0, 1, 'foo', 2], list.to_a
      end
    end
  end

  describe '#delete' do
    it 'raises error if block and value are passed' do
      err = assert_raises ArgumentError do
        assert_nil list.delete('x') { |d| d == 'x' }
      end
      assert_equal err.message, 'either value or block should be passed'
    end

    describe 'by block' do
      it 'returns nil if list is empty' do
        assert_nil list.delete { |d| d == 'x' }
      end

      it 'deletes value in first matching node' do
        calls_count = 0
        list.push('foo')
        list.push('foo')
        list.push('bar')
        list.push('foo')
        list.delete { |d| calls_count += 1;d == 'bar' }
        assert_equal ['foo', 'foo', 'foo'], list.to_a
        assert_equal 3, calls_count
      end

      it 'returns deleted value' do
        list.push('foo')
        assert_equal 'foo', list.delete { |d| d == 'foo' }
      end

      it 'decreases length of list' do
        list.push('foo')
        list.push('bar')
        list.push('foo')
        list.delete { |d| d == 'foo' }
        assert_equal 2, list.length
        assert_equal ['bar', 'foo'], list.to_a
      end

      describe 'position edge cases' do
        before do
          list.push(0)
          list.push(1)
          list.push(2)
        end

        it 'deletes value from head' do
          list.delete { |d| d == 0 }
          assert_equal [1, 2], list.to_a
          assert_equal 1, list.first
        end

        it 'deletes value from middle' do
          list.delete { |d| d == 1 }
          assert_equal [0, 2], list.to_a
        end

        it 'deletes value from tail' do
          list.delete { |d| d == 2 }
          assert_equal [0, 1], list.to_a
          assert_equal 1, list.last
        end
      end
    end

    describe 'by data equality' do
      it 'returns nil if list is empty' do
        assert_nil list.delete('x')
      end

      it 'deletes value in first node' do
        list.push('foo')
        list.push('foo')
        list.push('bar')
        list.push('foo')
        list.delete('foo')
        assert_equal ['foo', 'bar', 'foo'], list.to_a
      end

      it 'returns deleted value' do
        list.push('foo')
        assert_equal 'foo', list.delete('foo')
      end

      it 'decreases length of list' do
        list.push('foo')
        list.push('bar')
        list.push('foo')
        list.delete('foo')
        assert_equal 2, list.length
        assert_equal ['bar', 'foo'], list.to_a
      end

      describe 'position edge cases' do
        before do
          list.push(0)
          list.push(1)
          list.push(2)
        end

        it 'deletes value from head' do
          list.delete(0)
          assert_equal [1, 2], list.to_a
          assert_equal 1, list.first
        end

        it 'deletes value from middle' do
          list.delete(1)
          assert_equal [0, 2], list.to_a
        end


        it 'deletes value from tail' do
          list.delete(2)
          assert_equal [0, 1], list.to_a
          assert_equal 1, list.last
        end
      end
    end

    describe 'by node' do
      it 'deletes first node' do
        list.push(node_1)
        list.push(node_2)
        list.push(node_3)
        list.delete(node_1)
        assert_equal ['bar', 'baz'], list.to_a
      end

      it 'returns deleted value' do
        list.push(node_1)
        list.delete(node_1)
        assert_equal node_1.data, list.delete(node_1)
      end

      it 'decreases length of list' do
        list.push('foo')
        list.push('bar')
        list.push('baz')
        list.delete('foo')
        assert_equal 2, list.length
      end

      describe 'position edge cases' do
        before do
          list.push(node_1)
          list.push(node_2)
          list.push(node_3)
        end

        it 'deletes value from head' do
          list.delete(node_1)
          assert_equal ['bar', 'baz'], list.to_a
          assert_equal 'bar', list.first
        end

        it 'deletes value from middle' do
          list.delete(node_2)
          assert_equal ['foo', 'baz'], list.to_a
        end


        it 'deletes value from tail' do
          list.delete(node_3)
          assert_equal ['foo', 'bar'], list.to_a
          assert_equal 'bar', list.last
        end
      end
    end
  end

  describe '#delete_all' do
    it 'raises error if block and value are passed' do
      err = assert_raises ArgumentError do
        assert_nil list.delete_all('x') { |d| d == 'x' }
      end
      assert_equal err.message, 'either value or block should be passed'
    end

    describe 'by block' do
      it 'returns nil if list is empty' do
        assert_equal list.delete_all { |d| d == 'x' }, []
      end

      it 'deletes value in first matching node' do
        list.push('foo')
        list.push('foo')
        list.push('bar')
        list.push('foo')
        list.delete_all { |d| d == 'foo' }
        assert_equal ['bar'], list.to_a
      end

      it 'returns deleted value' do
        list.push('foo')
        assert_equal ['foo'], list.delete_all { |d| d == 'foo' }
      end

      it 'decreases length of list' do
        list.push('foo')
        list.push('bar')
        list.push('foo')
        list.delete_all { |d| d == 'foo' }
        assert_equal 1, list.length
        assert_equal ['bar'], list.to_a
      end
    end

    describe 'by data equality' do
      it 'returns nil if list is empty' do
        assert_nil list.delete('x')
      end

      it 'deletes all matched values' do
        list.push('foo')
        list.push('foo')
        list.push('bar')
        list.push('foo')
        list.delete_all('foo')
        assert_equal ['bar'], list.to_a
      end

      it 'returns deleted value' do
        list.push('foo')
        assert_equal ['foo'], list.delete_all('foo')
      end

      it 'decreases length of list' do
        list.push('foo')
        list.push('bar')
        list.push('foo')
        list.delete_all('foo')
        assert_equal 1, list.length
        assert_equal ['bar'], list.to_a
      end
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

  describe '#reverse' do
    it 'returns new empty list when receiver list is empty' do
      refute_equal list, list.reverse
    end

    it 'returns new list in reverse order' do
      list.push(node_1)
      refute_equal list.reverse, list.reverse!
    end

    it 'reverses order of nodes' do
      list.push(node_1)
      list.push(node_2)
      new_list = list.reverse
      assert_equal %w(bar foo), [new_list.first, new_list.last]
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

  describe '#each_node' do
    it 'returns enumerator if no block given' do
      assert_instance_of Enumerator, list.each_node
    end

    it 'pass each node data to the block' do
      list.push(node_1)
      list.push(node_2)
      nodes = []
      list.each_node { |e| nodes << e }
      assert_equal %w(foo bar), nodes.map(&:data)
      assert_equal true, nodes.all? { |n| n.is_a?(LinkedList::Node) }
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
      assert_equal %w(foo bar), nodes
    end
  end

  describe '#each_node' do
    it 'returns enumerator if no block given' do
      assert_instance_of Enumerator, list.each
    end

    it 'pass each node data to the block' do
      list.push(node_1)
      list.push(node_2)
      nodes = []
      list.each_node { |e| nodes << e }
      assert_equal %w(foo bar), nodes.map(&:data)
    end
  end

  describe '#reverse_each' do
    it 'returns enumerator if no block given' do
      assert_instance_of Enumerator, list.each
    end

    it 'pass each node data to the block' do
      list.push(node_1)
      list.push(node_2)
      nodes = []
      list.reverse_each { |e| nodes << e }
      assert_equal %w(bar foo), nodes
    end
  end

  describe '#reverse_each_node' do
    it 'returns enumerator if no block given' do
      assert_instance_of Enumerator, list.each
    end

    it 'pass each node data to the block' do
      list.push(node_1)
      list.push(node_2)
      nodes = []
      list.reverse_each_node { |e| nodes << e }
      assert_equal %w(bar foo), nodes.map(&:data)
    end
  end

  describe '#inspect' do
    it 'includes class name' do
      assert_match(/LinkedList::List/, list.inspect)
    end

    it 'includes object id' do
      assert_match(/#{list.object_id.to_s(16)}/, list.inspect)
    end

    it 'includes node values' do
      list.push(node_1)
      assert_match(/foo/, list.inspect)
    end
  end

  describe 'conversion' do
    it '#to_list returns self' do
      assert_equal list, list.to_list
    end
  end
end
