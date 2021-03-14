# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

if ENV["BOOT_PROFILE"]
  StackProf.stop
  Rails.root.join("tmp/flamegraph").mkpath
  Rails.root.join("tmp/flamegraph/boot.#{Rails.env}.dump").write(JSON.generate(StackProf.results))
  system("yarn speedscope #{Rails.root.join("tmp/flamegraph/boot.#{Rails.env}.dump")}")
end
