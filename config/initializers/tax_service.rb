Rails.autoloaders.main.on_load("TaxService") do
  TaxService.province = "ON"
end
