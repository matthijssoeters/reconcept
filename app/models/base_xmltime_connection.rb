class BaseXmltimeConnection
  URL = "https://api.xmltime.com/"
  SERVICE = nil

  def request_api args
    args = setup_connection_args.merge(args)

    response = Excon.get(url + query(args))
    return "Error" if response.status != 200
    return JSON.parse(response.body)
  end

  private
  def setup_connection_args
    timestamp = Time.now.getutc.strftime('%FT%T')
    return { accesskey: Rails.application.credentials.xmltime[:accesskey],
              timestamp: timestamp,
              signature: signature(timestamp),
              version:   3,
              out:       'js'
            }
  end

  def signature timestamp
    message = Rails.application.credentials.xmltime[:accesskey] + service_name + timestamp
    digest = OpenSSL::HMAC.digest('sha1', Rails.application.credentials.xmltime[:secretkey], message)
    Base64.encode64(digest).chomp
  end

  def url
    fail NotImplementedError
  end

  def service_name
    fail NotImplementedError
  end

  def query args
    return args.collect{|key, value| [key.to_s, CGI::escape(value.to_s)].join('=')}.join(';')
  end

  def timetest
    Time.now.getutc.strftime('%FT%T')
  end
end