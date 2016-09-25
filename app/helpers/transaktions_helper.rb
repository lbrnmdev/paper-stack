module TransaktionsHelper
  def transaktion_date_and_time date_time
    zoned_time = date_time
    begin
      zoned_time = date_time.in_time_zone(session[:login_time_zone])
    rescue => e
      logger.error "Error rendering date time in correct time zone: #{e.message}"
    end
    zoned_time.strftime("%a, %b %d, %Y at %I:%M:%S%p %Z")
  end
end
