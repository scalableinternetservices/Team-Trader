class Array
  def mean
    total = self.inject(:+)
    total.to_f / self.length
  end
end