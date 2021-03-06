class Tree
  100_000.times do |number|
    const_set("Branch#{number}", Class.new)
  end
end
