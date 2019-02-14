module GameMath
  def sort_and_find_difference(ele_1, ele_2)
    math = [ele_1.to_i, ele_2.to_i]
    math = math.sort.reverse
    math.first - math.last
  end
end
