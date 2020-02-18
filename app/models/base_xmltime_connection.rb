class BaseXmltimeConnection
  URL = "https://api.xmltime.com/"
  SERVICE = nil

  def request_api args
    args = setup_connection_args.merge(args)

    response = Excon.get(url + query(args))
    if response.status != 200
      errors.add(:request_api, message: JSON.parse(response.body)[errors].join("\n"))
      return nil
    end
    return JSON.parse(response.body)
  end

  protected
  def setup_connection_args
    timestamp = Time.now.getutc.strftime('%FT%T')
    return { accesskey: access_key,
              timestamp: timestamp,
              signature: signature(timestamp),
              version:   3,
              out:       "js"
            }
  end

  def signature timestamp
    message = access_key + service_name + timestamp
    digest = OpenSSL::HMAC.digest("sha1", secret_key, message)
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

  def access_key
    Rails.application.credentials.xmltime[Rails.env.to_sym][:access_key]
  end

  def secret_key
    Rails.application.credentials.xmltime[Rails.env.to_sym][:secret_key]
  end
end