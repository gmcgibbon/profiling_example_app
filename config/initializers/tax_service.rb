Rails.application.reloader.to_prepare do
  TaxService.province = "ON"
end
