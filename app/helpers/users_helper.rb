module UsersHelper

  # returns time zone from freegeoip given an ip, default to utc
  # TODO wrap implementation in begin rescue that returns a default if stuff goes wrong
  # TODO benchmark this to see how long it adds to the login process
  def time_zone_from_ip ip
    uri = URI("http://freegeoip.net/json/#{ip}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)["time_zone"] || "Etc/GMT"
  end
end
