module ApplicationHelper
  def money(price)
    "$%.2f" % price
  end
end
