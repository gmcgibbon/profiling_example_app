module ShippingService
  HOST = "localhost"
  PORT = 9292

  class << self
    def amount
      @amount ||= BigDecimal(rates_path.read.match(/local: \$(.*)/)[1])
    end

    def download_rates
      rates_path.write('')
      rates_path.open('a') do |file|
        client.get("/shipping_rates.txt") { |rate| file << rate }
      end
    rescue Net::ReadTimeout, Errno::ECONNREFUSED
      false
    end

    private

    def client
      @client ||= Net::HTTP.new(HOST, PORT).tap do |client|
        client.read_timeout = 2 # seconds
      end
    end

    def rates_path
      Rails.root.join("tmp/shipping_rates.txt")
    end
  end
end
