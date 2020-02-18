class AstronomyXmltimeConnection < BaseXmltimeConnection
  SERVICE = "astronomy"

  def self.lunar_phase date
    if validate_date date
      res = request_api( {object: 'moon', placeid: 16, startdt: date, types: "phase"} )
      res.keys.include?("errors") ? parse_errors(res) : parse_moon_phase(res)
    else
      return {errors: "Invalid date."}
    end
  end

  protected
  def self.url
    "#{URL}#{service_name}?"
  end

  def self.service_name
    SERVICE
  end

  private
  def self.validate_date date
    begin
      return (date =~ /^\d{4}-\d{2}-\d{2}$/ && Date.parse(date)) ? true : false
    rescue ArgumentError
      return false
    end
  end

  def self.parse_moon_phase res
    (res["locations"].first["geo"].merge(res["locations"].first["astronomy"]["objects"].first["days"].first.except("events"))).to_json
  end

  def self.parse_errors res
    res.except("version")
  end
end