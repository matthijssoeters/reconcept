class BaseXmltimeConnection
  URL = "https://api.xmltime.com/"
  SERVICE = nil

  def self.request_api args
    args = setup_connection_args.merge(args)

    response = Excon.get(url + query(args))
    if response.status != 200
      return {errors: "Couldn't receive data."}
    end
    return JSON.parse(response.body)
  end

  protected
  def self.setup_connection_args
    timestamp = Time.now.getutc.strftime('%FT%T')
    return { accesskey: access_key,
              timestamp: timestamp,
              signature: signature(timestamp),
              version:   3,
              out:       "js"
            }
  end

  def self.signature timestamp
    message = access_key + service_name + timestamp
    digest = OpenSSL::HMAC.digest("sha1", secret_key, message)
    Base64.encode64(digest).chomp
  end

  def self.url
    fail NotImplementedError
  end

  def self.service_name
    fail NotImplementedError
  end

  def self.query args
    return args.collect{|key, value| [key.to_s, CGI::escape(value.to_s)].join('=')}.join(';')
  end

  def self.access_key
    Rails.application.credentials.xmltime[Rails.env.to_sym][:access_key]
  end

  def self.secret_key
    Rails.application.credentials.xmltime[Rails.env.to_sym][:secret_key]
  end
end