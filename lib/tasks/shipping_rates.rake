namespace(:shipping_rates) do
  desc("Download local shipping rates")
  task(:download) do
    require "shipping_service"
    ShippingService.download_rates
  end
end
