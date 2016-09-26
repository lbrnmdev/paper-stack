module SessionsHelper

  # returns time zone from freegeoip given an ip, default to utc
  # TODO wrap implementation in begin rescue that returns a default if stuff goes wrong
  # TODO benchmark this to see how long it adds to the login process
  def time_zone_from_ip ip
    uri = URI("http://freegeoip.net/json/#{ip}")
    zone = "UTC"
    logger.info "stepped into time_zone_from_ip"
    begin
      logger.info "stepped into begin block"
      response = Net::HTTP.start(uri.host, uri.port) {|http|
        http.open_timeout = 2
        http.read_timeout = 2
        logger.info "stepped into response block"
        http.request(Net::HTTP::Get.new(uri.request_uri))
      }
      parsed_zone = JSON.parse(response.body)["time_zone"]
      logger.info "stepped into after parsed_zone: time zone is #{parsed_zone}"
      zone = parsed_zone unless parsed_zone == ( "" || nil )
    rescue StandardError, Net::ReadOpenTimeout, Net::ReadTimeout => e
      zone = "UTC"
      logger.error "Error getting parsed time zone: #{e.message}"
    end

    zone
  end
end
