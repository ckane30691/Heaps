class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc ||= Proc.new do |el1, el2|
      -1 * (el1 <=> el2)
    end
  end

  def count
    @store.length
  end

  def extract
    firstVal = @store[0]
    lastVal = @store[count - 1]
    @store[0] = lastVal
    @store[count - 1] = firstVal
    @store.pop
    BinaryMinHeap.heapify_down(@store, 0, count)
    firstVal
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, count - 1, count)
    val
  end

  public
  def self.child_indices(len, parent_index)
    firstIdx = (parent_index * 2) + 1
    secondIdx = (parent_index * 2) + 2
    return nil if firstIdx >= len
    return secondIdx >= len ? [firstIdx] : [firstIdx, secondIdx]
  end

  def self.parent_index(child_idx)
    raise "root has no parent" if child_idx.zero?
    parentIdx = (child_idx - 1 ) / 2
    return parentIdx
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new do |el1, el2|
      (el1 <=> el2)
    end
    parent = array[parent_idx]
    childIdx1, childIdx2 = BinaryMinHeap.child_indices(len, parent_idx)
    return array if childIdx1.nil?
    childOne = array[childIdx1]
    if childIdx2.nil?
      smallestChild = childOne
    else
      childTwo = array[childIdx2]
      smallestChild = prc.call(childOne, childTwo) > 0 ? childTwo : childOne
    end
    smallestIdx = smallestChild == childOne ? childIdx1 : childIdx2
    if (prc.call(parent, smallestChild) > 0)
      array[smallestIdx] = parent
      array[parent_idx] = smallestChild
      parent_idx = smallestIdx
    end
    return array if prc.call(parent, smallestChild) <= 0
    return BinaryMinHeap.heapify_down(array, parent_idx, len, &prc)

  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new do |el1, el2|
      el1 <=> el2
    end
    return array if child_idx.zero?
    child = array[child_idx]
    parentIdx = BinaryMinHeap.parent_index(child_idx)
    parent = array[parentIdx]
    if prc.call(child, parent) < 0
      array[child_idx] = parent
      array[parentIdx] = child
      child_idx = parentIdx
    end
    return array if prc.call(child, parent) > 0
    return BinaryMinHeap.heapify_up(array, child_idx, len, &prc)
  end
end
