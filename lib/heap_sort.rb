require_relative "heap"

class Array
  def heap_sort!
    self.heapify_in_place
    self.extract
  end

  def heapify_in_place(idx = 1)
    BinaryMinHeap.heapify_up(self[0, idx], self[0, idx].length - 1, self[0, idx].length)
    return self if idx == self.length
    idx += 1
    self.heapify_in_place(idx)
  end

  def extract(idx = self.length - 1)
    self[0], self[idx] = self[idx], self[0]
    return self if idx == 0
    idx -= 1
    BinaryMinHeap.heapify_down(self[0, idx], self[0, idx].length - 1, self[0, idx].length)
    extract(idx)
  end
end
