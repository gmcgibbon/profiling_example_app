class TaxService
  class_attribute(:province)

  100_000.times do |number|
    const_set("Branch#{number}", Class.new)
  end
end
