require 'rails_helper'

RSpec.describe BaseXmltimeConnection, type: :model do

  describe 'request_api' do
    let(:args) { {first_key: "first test value", second_key: "second test value"} }

    it { expect { BaseXmltimeConnection.send(:request_api, args) }.to raise_error(NotImplementedError) }
  end

  describe 'query' do
    let(:args) { {first_key: "first test value", second_key: "second test value"} }

    it { expect(BaseXmltimeConnection.send(:query, args)).to eq "first_key=first+test+value;second_key=second+test+value" }
  end

  describe 'setup_connection_args' do
    it { expect { BaseXmltimeConnection.send(:setup_connection_args) }.to raise_error(NotImplementedError) }
  end

  describe 'url' do
    it { expect { BaseXmltimeConnection.send(:url) }.to raise_error(NotImplementedError) }
  end

  describe 'service_name' do
    it { expect { BaseXmltimeConnection.send(:service_name) }.to raise_error(NotImplementedError) }
  end

  describe 'access_key' do
    it { expect(BaseXmltimeConnection.send(:access_key)).to eq "test_access_key" }
  end

  describe 'secret_key' do
    it { expect(BaseXmltimeConnection.send(:secret_key)).to eq "test_secret_key" }
  end
end