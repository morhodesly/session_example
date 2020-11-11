module LoginsHelper
  def device_description(user_agent)
    device = DeviceDetector.new(user_agent)
    "#{ device.name } #{ device.full_version } on #{ device.os_name } #{ device.os_full_version }"
  end
  def device_location(ip_address)
      if ip = Ip.find_by(address: ip_address)
        "#{ ip.city }, #{ ip.country }"
      else
        location = Geoip2.city(ip_address)
        if location.error
          Ip.create!(address: ip_address, city: "Unknown", country: "Unknown")
          "Unknown"
        else
          Ip.create!(address: ip_address, city: location.city.names[:en],
                    country: location.country.names[:en])
                    "#{ location.city.names[:en] }, #{ location.country.names[:en] }"
        end
      end
    end
end
