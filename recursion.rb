def range(start, en)
  if start > en
    []
  elsif start == en
    [start]
  else
    range(start, en - 1) << en
  end
end

def sum_rec(arr)
  if arr.empty?
    0
  elsif arr.size == 1
    arr[0]
  else
    arr.pop + sum_rec(arr)
  end
end

def sum_it(arr)
  arr.inject(0) {|sum, item| sum + item}
end

def exp1(b, n)
  return 1 if n == 0
  b * exp1(b, n-1)
end

def exp2(b, n)
  if n == 0
    1
  elsif n == 1
    b
  else
    res = exp2(b, n/2) ** 2
    return res * b if n.odd?
    res
  end
end

class Array
  def deep_dup
    if none? {|e| e.is_a?(Array)}
      arr = []
      each { |e| arr << e }
      arr
    else
      res = []
      each do |e|
        if !e.is_a?(Array)
          res << e
        else
          res << e.deep_dup
        end
      end
      res
    end
  end
end

def fib_rec(n)
  if n == 0
    [0]
  elsif n ==1
    [0, 1]
  else 
    arr = fib_rec(n-1)
    arr << arr[-1] + arr[-2]
  end
end

def fib_it(n)
  return [0] if n == 0
  return [0, 1] if n == 1
  
  res = [0, 1]
  (n-1).times do |_|
    res << res[-1] + res[-2]
  end
  res
end

def bsearch(array, target)
  return nil if target < array.first || target > array.last
  mid = array.length / 2
  if array[mid] == target
    mid
  elsif array[mid] > target
    bsearch(array[0...mid], target)
  else
    bsearch(array[mid+1..-1], target)+mid+1
  end   
end

def make_change(amt, denoms=[25, 10, 5, 1])
  if denoms.include?(amt)
    [amt]
  else
    arr = denoms.select {|d| d <= amt}.map do |denom|
      make_change(amt - denom, denoms) << denom
    end
    
    arr.min {|a1, a2| a1.length <=> a2.length}
  end
end 

def merge_sort(arr)
  if arr.size == 0 || arr.size == 1
    arr
  else
    mid = arr.size / 2
    a1 = merge_sort(arr[0...mid])
    a2 = merge_sort(arr[mid..-1])
    
    res = []
    while !a1.empty? && !a2.empty?
      if a1.first > a2.first
        res << a2.shift
      else
        res << a1.shift
      end
    end
    
    if a1.empty?
      res += a2
    else
      res += a1
    end
    
    res
  end
end

def subsets(arr)
  return [[]] if arr == []
  last = arr.pop
  all_but_last = subsets(arr)
  p all_but_last
  all_but_last + all_but_last.map {|e| e.dup<<last} 
end


  