class Array
  def my_each(&prc)
    i = 0
    while i < size
      prc.call(self[i])
      i += 1
    end
    self
  end
  
  def my_map(&prc)
    res = []
    my_each do |el|
      res << prc.call(el)
    end
    res
  end
  
  def my_select(&prc)
    res = []
    my_each do |el|
      res << el if prc.call(el)
    end
    res
  end
  
  def my_inject(&prc)
    res = self.first
    my_each do |el|
      res = prc.call(res, el)
    end
    res
  end
  
  def my_sort!(&prc)
    sort!(&prc)
  end
  
  def my_sort(&prc)
    dup.my_sort!(&prc)
  end
end

def eval_block(*args, &prc)
  if prc.nil?
    puts "NO BLOCK GIVEN"
  else
    prc.call(*args)
  end
end