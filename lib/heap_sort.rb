require_relative "heap"

class Array
  def heap_sort!
    self.heapify_in_place
    self.extract
  end

  def heapify_in_place(idx = 1)
    return self if idx == self.length
    BinaryMinHeap.heapify_up(self, idx)
    idx += 1
    heapify_in_place(idx)
  end

  def extract(idx = self.length)
    return self.reverse! if idx == 1
    self[0], self[idx - 1] = self[idx - 1], self[0]
    idx -= 1
    BinaryMinHeap.heapify_down(self, 0, idx)
    extract(idx)
  end
end
