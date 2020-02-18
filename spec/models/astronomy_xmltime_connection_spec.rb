require 'rails_helper'

RSpec.describe AstronomyXmltimeConnection, type: :model do

  describe 'moon_phase' do
    it '2020-02-01' do
      VCR.use_cassette("moon_phase_01-02-2020", :match_requests_on => [:method, :host, :headers]) do
        expect(AstronomyXmltimeConnection.moon_phase("2020-02-01")).to eq "{\"name\":\"Amsterdam\",\"country\":{\"id\":\"nl\",\"name\":\"Netherlands\"},\"latitude\":52.373,\"longitude\":4.894,\"date\":\"2020-02-01\",\"moonphase\":\"waxingcrescent\"}"
      end
    end

    it '2020-02-17' do
      VCR.use_cassette("moon_phase_17-02-2020", :match_requests_on => [:method, :host, :headers]) do
        expect(AstronomyXmltimeConnection.moon_phase("2020-02-17")).to eq "{\"name\":\"Amsterdam\",\"country\":{\"id\":\"nl\",\"name\":\"Netherlands\"},\"latitude\":52.373,\"longitude\":4.894,\"date\":\"2020-02-17\",\"moonphase\":\"waningcrescent\"}"
      end
    end

    it 'expired' do
      VCR.use_cassette("moon_phase_expired", :match_requests_on => [:method, :host, :headers]) do
        expect(AstronomyXmltimeConnection.moon_phase("2020-02-17")["errors"]).to eq ["Request expired."]
      end
    end

    it 'wrong date' do
      expect(AstronomyXmltimeConnection.moon_phase("20-12-2020")).to eq({errors: "Invalid date."})
      expect(AstronomyXmltimeConnection.moon_phase("2020-02-31")).to eq({errors: "Invalid date."})
    end
  end

  describe 'setup_connection_args' do
    it '' do
      freeze_time do
        message = AstronomyXmltimeConnection.send(:access_key) + AstronomyXmltimeConnection.send(:service_name) + Time.now.getutc.strftime('%FT%T')
        digest = OpenSSL::HMAC.digest("sha1", AstronomyXmltimeConnection.send(:secret_key), message)
        signature = Base64.encode64(digest).chomp

        expect(AstronomyXmltimeConnection.send(:setup_connection_args)).to eq({accesskey: "test_access_key", timestamp: Time.now.getutc.strftime('%FT%T'), signature: signature, version: 3, out: "js"})
      end
    end
  end

  describe 'url' do
    it { expect(AstronomyXmltimeConnection.send(:url)).to eq "https://api.xmltime.com/astronomy?" }
  end

  describe 'service' do
    it { expect(AstronomyXmltimeConnection.send(:service_name)).to eq "astronomy" }
  end

  describe 'validate_date' do
    it { expect(AstronomyXmltimeConnection.send(:validate_date, "2020-02-17")).to eq true }
    it { expect(AstronomyXmltimeConnection.send(:validate_date, "2020-02-31")).to eq false }
    it { expect(AstronomyXmltimeConnection.send(:validate_date, "20-20-02-17")).to eq false }
    it { expect(AstronomyXmltimeConnection.send(:validate_date, "20-12-2017")).to eq false }
  end
end