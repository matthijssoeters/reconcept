class AstronomyXmltimeConnection < BaseXmltimeConnection
  SERVICE = "astronomy"

  def moon_phase date
    if validate_date date
      res = request_api( {object: 'moon', placeid: 16, startdt: date, types: "phase"} )
      res.keys.include?("errors") ? parse_errors(res) : parse_moon_phase(res)
    else
      return false
    end
  end

  protected
  def url
    "#{URL}#{service_name}?"
  end

  def service_name
    SERVICE
  end

  private
  def validate_date date
    begin
      return (date =~ /^\d{4}-\d{2}-\d{2}$/ && Date.parse(date)) ? true : false
    rescue ArgumentError
      # errors.add(:request_api, message: JSON.parse(response.body)[errors].join("\n"))
      return false
    end
  end

  def parse_moon_phase res
    (res["locations"].first["geo"].merge(res["locations"].first["astronomy"]["objects"].first["days"].first.except("events"))).to_json
  end

  def parse_errors res
    res.except("version")
  end
end