require 'test_helper'

describe LinkedList::Node do
  let(:node) { create_node('foo') }

  describe 'instantiation' do
    it 'assigns data' do
      assert_equal 'foo', node.data
    end

    it 'assigns nil to next' do
      assert_nil node.next
    end

    it 'assigns nil to prev' do
      assert_nil node.prev
    end
  end

  describe 'accessors' do
    it '#data' do
      node.data = 'bar'
      assert_equal 'bar', node.data
    end

    it '#next' do
      node.next = 'bar'
      assert_equal 'bar', node.next
    end

    it '#prev' do
      node.prev = 'xyz'
      assert_equal 'xyz', node.prev
    end
  end

  describe 'conversion' do
    it '#to_node returns self' do
      assert_equal node, node.to_node
    end
  end
end
